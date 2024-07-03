

class PrisonerModel  {
  final dynamic id;
  final String? name;
 final String? date_of_birth , date_of_arrest;
  final String? photo_url,place_of_birth,created_at,submitted_by_name;
  final String type = 'Prisoner';
  final String? life_story;
   int? views,submitted_by;
  PrisonerModel(
      {
        this.id,
         this.name,
        this.photo_url,
         this.date_of_birth,
        this.date_of_arrest,
        this.place_of_birth,
        this.submitted_by,
        this.created_at,
        this.life_story,
        this.submitted_by_name,
        this.views
      });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date_of_birth' : date_of_birth,
      'date_of_arrest': date_of_arrest,
      'place_of_birth': place_of_birth,
      'photo_url': photo_url,
      'life_story': life_story,
      'created_at': created_at,
      'submitted_by': submitted_by,
      'submitted_by_name': submitted_by_name,
      'views': views,
    };

  }
  Map<String, dynamic> toJson() {
    return {
      '_id' : id,
      'name': name,
      'date_of_birth' : date_of_birth,
      'date_of_arrest': date_of_arrest,
      'place_of_birth': place_of_birth,
      'photo_url': photo_url,
      'life_story': life_story,
      'created_at': created_at,
      'submitted_by': submitted_by,
      'submitted_by_name': submitted_by_name,
      'views': views,
    };

  }

  factory PrisonerModel.fromMap(Map<String, dynamic> map) {


    return PrisonerModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      date_of_birth: map['date_of_birth'] ?? '0000-00-00',
      date_of_arrest: map['date_of_arrest'] ?? '0000-00-00',
      place_of_birth: map['place_of_birth'] ?? '',
      photo_url: map['photo_url'] ?? 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
      life_story: map['life_story'] ?? '',
      submitted_by_name: map['submitted_by_name'] ?? '',
      created_at: map['created_at'] ?? '0000-00-00',
      submitted_by: map['submitted_by'] ?? 6,
      views: map['views'] ?? 0
    );

  }

  factory  PrisonerModel.fromJson(Map<String, dynamic> json) {


    return  PrisonerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      date_of_birth: json['date_of_birth'] ?? '0000-00-00',
      date_of_arrest: json['date_of_arrest'] ?? '0000-00-00',
      place_of_birth: json['place_of_birth'] ?? '',
      photo_url: json['photo_url'] ?? 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
      life_story: json['life_story'] ?? '',
      submitted_by_name:json['submitted_by_name'] ?? '' ,
      created_at: json['created_at'] ?? '0000-00-00',
      submitted_by: json['submitted_by'] ?? 6,
        views: json['views'] ?? 0
    );
  }


}
