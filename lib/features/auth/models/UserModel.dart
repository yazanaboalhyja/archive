import 'package:flutter/foundation.dart';


class UserModel  {
  dynamic id;
  final String? username;
  final String? name;
  final Role? role;
  String? password;

  UserModel(
      {
        this.id,
        required this.username,
        required this.name,
        required this.role,
        this.password,
      });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'role' : role,
      'name' : name
    };

  }
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'password': password,
      'name' : name,
      'role' : role.toString().split(".").last,
      'username' : username,
    };

  }

  factory UserModel.fromMap(Map<String, dynamic> map) {

    late Role role =Role.User;
    if (map['role']== 'Admin'){
      role = Role.Admin;
    }
    else if(map['role']== 'User'){
      role = Role.User;
    }

    return UserModel(
        username: map['username'] ?? '',
        name: map['name'] ?? '',
        role: role );

  }



  factory  UserModel.fromJson(Map<String, dynamic> json) {
    late Role role = Role.User
    ;

    if (json['role']== 'Admin'){
      role = Role.Admin;
    }
    else if(json['role']== 'User'){
      role = Role.User;
    }


    return UserModel(
        id: json['_id']  ,
        username: json['username'] ?? '',
         name: json['name'] ?? '',
        role: role ,

    );
  }


}

enum Role {

  User,
  Admin

}
