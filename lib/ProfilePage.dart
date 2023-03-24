// import 'dart:html';

import 'package:app_for_api/profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

//import 'package:app_for_api/models/models.dart';

class ProfilePage extends StatefulWidget {
  final String? name;
  final String? email;


  const ProfilePage({Key? key, this.name, this.email}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? newName;
  String? newEmail;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'name: ${widget.name}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'email: ${widget.email}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              initialValue: widget.name,
              decoration: InputDecoration(
                labelText: 'New name',
              ),
              onChanged: (value) {
                setState(() {
                  newName = value;
                });
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              initialValue: widget.email,
              decoration: InputDecoration(
                labelText: 'New email',
              ),
              onChanged: (value) {
                setState(() {
                  newEmail = value;
                });
              },
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              child: Text('Save changes'),
              onPressed: () {
                saveNew(widget.email, widget.name);
                updateProfile(newName, newEmail);
// TODO: Implement saving changes to API
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> updateProfile(String? newName, String? newEmail) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  final response = await dio.post('/token',
      options: Options(headers: {'Authorization': 'Bearer ${token}'}),
      data: {
        'userName': newName,
        'email': newEmail,
      });
  if (response.statusCode == 200) {
    // Обновление данных прошло успешно
  } else {
    throw Exception('Failed to update profile');
  }
}

Future<void> saveNew(String? newmail, String? newname) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  newmail = prefs.getString("email")!;
  newname = prefs.getString("name")!;
}
