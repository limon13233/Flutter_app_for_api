class LoginData {
  final int id;
  final String userName;
  final String email;
  final String refreshToken;

  LoginData({
    required this.id,
    required this.userName,
    required this.email,
    required this.refreshToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      refreshToken: json['refreshToken'],
    );
  }
}




