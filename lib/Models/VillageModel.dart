import 'dart:math';

import 'package:flutter/material.dart';

import '../data.dart';

class VillageModel {
  dynamic id;
  String village_name;
  String image_url;
  String city;
  String historical_context , current_status;
  final String type = "Village";
  Color? bgColor;
  final String? created_at, submitted_by_name;
  final int views , submitted_by;

  VillageModel({
    this.id,
    required this.village_name,
    required this.image_url,
    required this.city,
    required this.historical_context,
    required this.current_status,
    this.bgColor,
    this.created_at,
    required this.views,
    required this.submitted_by_name,
    required this.submitted_by,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'village_name': village_name,
      'image_url': image_url,
      'city': city,
      'historical_context': historical_context,
      'submitted_by': submitted_by,
      'views': views,
      'created_at': created_at,
      'current_status': current_status,
      'submitted_by_name': submitted_by_name,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'village_name': village_name,
      'image_url': image_url,
      'city': city,
      'historical_context': historical_context,
      'submitted_by': submitted_by,
      'views': views,
      'created_at': created_at,
      'current_status': current_status,
      'submitted_by_name': submitted_by_name,


    };
  }

  factory VillageModel.fromMap(Map<String, dynamic> map) {
    return VillageModel(
      id: map['id'] ?? '',
      village_name: map['village_name'] ?? '',
submitted_by_name: map['submitted_by_name'] ?? '',
      historical_context: map['historical_context'] ?? '',
      image_url: map['image_url'] ?? 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
      bgColor: colors[Random().nextInt(3)],
      city: map['city'] ?? '',
      views: map['views'] ?? 0,
      submitted_by: map['submitted_by']??6,
      current_status:  map['current_status'],
      created_at: map['created_at']??'0000-00-00',
    );
  }

  factory VillageModel.fromJson(Map<String, dynamic> json) {
    return VillageModel(
      id: json['id'] ?? '',
      village_name: json['village_name'] ?? '',
      image_url: json['image_url'] ?? 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
      historical_context: json['historical_context'] ?? '',
      city: json['city'] ?? '',
      submitted_by_name: json['submitted_by_name'] ?? '',

      bgColor: colors[Random().nextInt(colors.length-1)],
      current_status: json['current_status'] ?? '',
      views: json['views'] ?? 1,
      submitted_by: json['submitted_by'] ?? 6,

    );
  }
}

