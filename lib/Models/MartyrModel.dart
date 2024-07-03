

class MartyrModel  {
  final dynamic id;
  final String? full_name;
  final String? date_of_birth , date_of_death ,created_at ;
  final String image_url,nationality  , description ;

  final String? cause_of_death , place_of_death , submitted_by_name ;
  final String type ="Martyr";
   int views =0 ,submitted_by ;
  MartyrModel(
      {
        this.id,
        this.full_name,
        required this.image_url,
        this.date_of_birth,
        this.date_of_death,
        this.created_at,
        required this.description,
        required this.nationality,
        this.cause_of_death,
        this.place_of_death,
        required this.submitted_by,
        required this.submitted_by_name,
          required this.views,
      });

  Map<String, dynamic> toMap() {
    return {
      'full_name': full_name,
      'date_of_birth' : date_of_birth,
      'date_of_death': date_of_death,
      'nationality': nationality,
      'image_url': image_url,
      'type': type,
      'cause_of_death': cause_of_death,
      'place_of_death': place_of_death,
      'created_at': created_at,
      'views': views,
      'submitted_by': submitted_by,
      'submitted_by_name': submitted_by_name,
      'description': description,
    };

  }
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'full_name': full_name,
      'date_of_birth' : date_of_birth,
      'date_of_death': date_of_death,
      'nationality': nationality,
      'image_url': image_url,
      'type': type,
      'cause_of_death': cause_of_death,
      'place_of_death': place_of_death,
      'created_at': created_at,
      'views': views,
      'submitted_by': submitted_by,
      'submitted_by_name': submitted_by_name,
      'description': description,
    };

  }

  factory MartyrModel.fromMap(Map<String, dynamic> map) {

    return MartyrModel(
      id: map['id'] ?? '',
      full_name: map['full_name'] ?? '',
      date_of_birth: map['date_of_birth'] ?? '0000-00-00',
      date_of_death: map['date_of_death'] ?? '0000-00-00',
      nationality: map['nationality'] ?? '',
      image_url: map['image_url'] ?? 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
      created_at: map['created_at'] ?? '0000-00-00',
      views: map['views'] ?? 0,
      submitted_by: map['submitted_by'] ?? 6,
      submitted_by_name:map['submitted_by_name'] ??'' ,
      cause_of_death: map['cause_of_death'] ?? '',
      place_of_death:map['place_of_death'] ?? '',
      description:map['description'] ?? '',
    );

  }

  factory  MartyrModel.fromJson(Map<String, dynamic> json) {



    return  MartyrModel(
      id: json['id'] ?? '',
      full_name: json['full_name'] ?? '',
      date_of_birth: json['date_of_birth'] ?? '0000-00-00',
      date_of_death: json['date_of_death'] ?? '0000-00-00',
      nationality: json['nationality'] ?? '',
      image_url: json['image_url'] ?? 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
      created_at: json['created_at'] ?? '0000-00-00',
      views: json['views'] ?? 0,
      submitted_by: json['submitted_by'] ?? 6,
      submitted_by_name: json['submitted_by_name'] ?? '',
      cause_of_death: json['cause_of_death'] ?? '',
      place_of_death:json['place_of_death'] ?? '',
      description:json['description'] ?? '',
    );

  }


}
