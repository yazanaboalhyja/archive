import 'dart:convert';

class User {
  final String fullname;
  final String? name;
  final String username;
  final String email;
  final String password;
  final String token;
  final String type;
  final String id;
  final String pin;
  final String deviceToken;
  final bool isVerified;
  final bool? emailVerified;
  User({
    required this.fullname,
    required this.username,
    required this.email,
    required this.password,
    required this.token,
    required this.type,
    required this.id,
    required this.pin,
    required this.deviceToken,
    required this.isVerified,
     this.name,
     this.emailVerified
  });

  Map<String, dynamic> toMap() {
    return {
      'fullname': name,
      'username': username,
      'name': name,

      'email': email,
      'password': password,
      'token': token,
      'type': type,
      'id': id,
      'pin': pin,
      'deviceToken': deviceToken,
      'isVerified': isVerified,
      'emailVerified': emailVerified,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullname: map['name'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      type: map['type'] ?? '',
      id: map['_id'] ?? '',
      pin: map['pin'] ?? '',
      deviceToken: map['deviceToken'] ?? '',
      isVerified: map['emailVerified'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}