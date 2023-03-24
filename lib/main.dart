import 'package:app_for_api/ProfilePage.dart';
import 'package:app_for_api/loginrequest.dart';
import 'package:app_for_api/loginresponse.dart';
import 'package:app_for_api/profile.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:ui' show lerpDouble;

import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio(BaseOptions(baseUrl: 'http://localhost:8888'));

class ApiClient {
  Future<bool> login(LoginRequest request) async {
    final response = await dio.post('/auth', data: request.toJson());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'token', LoginResponse.fromJson(response.data["data"]).token as String);
    prefs.setString('name',
        LoginResponse.fromJson(response.data["data"]).userName as String);
    return prefs.setString(
        'email', LoginResponse.fromJson(response.data["data"]).email as String);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: LoginPage(apiClient: apiClient),
    );
  }
}

class LoginPage extends StatefulWidget {
  final ApiClient apiClient;

  const LoginPage({Key? key, required this.apiClient}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  void _onLoginPressed() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final request = LoginRequest(
      userName: _emailController.text,
      password: _passwordController.text,
    );

    try {
      final response = await widget.apiClient.login(request);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfilePage(
            name: _emailController.text,
            email: prefs.getString("email"),
          ),
        ),
      );
    } on DioError catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to login: ${e.message}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Login'),
              onPressed: _isLoading ? null : _onLoginPressed,
            ),
          ],
        ),
      ),
    );
  }
}
