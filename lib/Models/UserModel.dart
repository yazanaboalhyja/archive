import 'package:flutter/foundation.dart';


class UserModel  {
  dynamic id;
  final String? username;
  final String? name;

  String? password;

  UserModel(
      {
        this.id,
        required this.username,
        required this.name,

        this.password,
      });

  Map<String, dynamic> toMap() {
    return {
      'username': username,

      'name' : name
    };

  }
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'password': password,
      'name' : name,

      'username' : username,
    };

  }

  factory UserModel.fromMap(Map<String, dynamic> map) {


    return UserModel(
        username: map['username'] ?? '',
        name: map['name'] ?? '',
         );

  }



  factory  UserModel.fromJson(Map<String, dynamic> json) {


    return UserModel(
        id: json['_id']  ,
        username: json['username'] ?? '',
         name: json['name'] ?? '',


    );
  }


}


