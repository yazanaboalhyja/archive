import 'dart:convert';

class User1 {
  final String name;
  final String username;
  final String email;
  final String password;
  final String token;
  final String type;
  final String id;
  final String pin;
  final String deviceToken;
  final bool emailVerified;
  User1({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.token,
    required this.type,
    required this.id,
    required this.pin,
    required this.deviceToken,
    required this.emailVerified,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'token': token,
      'type': type,
      'id': id,
      'pin': pin,
      'deviceToken': deviceToken,
      'emailVerified': emailVerified,
    };
  }

  factory User1.fromMap(Map<String, dynamic> map) {
    return User1(
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      type: map['type'] ?? 'Admin',
      id: map['_id'] ?? '',
      pin: map['pin'] ?? '',
      deviceToken: map['deviceToken'] ?? '',
      emailVerified: map['emailVerified'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory User1.fromJson(String source) => User1.fromMap(json.decode(source));
}
