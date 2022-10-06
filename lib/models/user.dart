import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  User({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  final String email;
  final String password;
  final bool rememberMe;

  factory User.fromMap(Map<String, dynamic> json) => User(
        email: json["email"],
        password: json["password"],
        rememberMe: json["rememberMe"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
        "rememberMe": rememberMe,
      };
}
