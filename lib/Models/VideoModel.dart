import 'package:flutter/material.dart';

class VideoModel {
  dynamic id;
  String video_path;
  String location;
  String description;
  final String type = "Video";
  String? submitted_by_name;
  String 	upload_date;
   int views ,submitted_by ;

  VideoModel({
    this.id,
    
    required this.video_path,
    required this.location,
    required this.description,
    required this.upload_date,
     required this.views ,
    required this.submitted_by_name ,
    required this.submitted_by,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'video_path': video_path,
      'location': location,
      'views': views,
      'description': description,
      'upload_date': upload_date,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'video_path': video_path,
      'views': views,
      'location': location,
      'description': description,
      'upload_date': upload_date,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      upload_date: map['upload_date'] ?? '0000-00-00',
      video_path: map['video_path'] ?? '',
      submitted_by: map['submitted_by'] ?? 6,
      submitted_by_name: map['submitted_by_name'] ??'',
      location: map['location'] ?? '',
      views: map['views'] ?? ''
    );
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? '',
      views: json['views'] ?? 0,
      video_path: json['video_path'] ?? '',
      description: json['description'] ?? '',
      upload_date: json['upload_date'] ?? '0000-00-00',
      location: json['location'] ?? '',
      submitted_by: json['submitted_by'] ?? 6,
      submitted_by_name: json['submitted_by_name'] ??''
    );
  }
}



