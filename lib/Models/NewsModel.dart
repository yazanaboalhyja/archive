

class NewsModel  {
  final dynamic id;
  final String? name;
  final String? author;
  final String? created_at;
  final String? description ,submitted_by_name;
  final String? photo_url;
  final String type='News';
  final int views , submitted_by;
  final String? category , source;

  NewsModel(
      {
        this.id,
        this.name,
        this.photo_url,
        this.author,
        this.created_at,
        this.description,
        required this.views,
        required this.submitted_by,
        this.submitted_by_name,
         this.category,
        this.source

      });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'author' : author,
      'created_at': created_at,
      'description': description,
      'photo_url': photo_url,
      'type': category,
      'source': source,

    };

  }
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name': name,
      'author' : author,
      'created_at': created_at,
      'photo_url': photo_url,
      'description': description,
      'type': category,
      'source': source,
    };

  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {


    return NewsModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      author: map['author'] ?? '',
      description: map['description'] ?? '',
      created_at: map['created_at'] ?? '0000-00-00',
      photo_url: map['photo_url'] ?? 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
      views: map['views'] ?? 0,
      submitted_by: map['submitted_by'] ?? 6,
      category: map['type'] ?? '',
      source: map['source'] ?? '',
      submitted_by_name: map['submitted_by_name'] ?? '',
    );

  }

  factory  NewsModel.fromJson(Map<String, dynamic> json) {

print(json['photo_url']);
    return  NewsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      created_at: json['created_at'] ?? '0000-00-00',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      photo_url: json['photo_url'] ?? 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
      views: json['views'] ?? 0,
      submitted_by: json['submitted_by'] ?? 0,
      category: json['type'] ?? '',
      source: json['source'] ?? '',
      submitted_by_name: json['submitted_by_name'] ?? '',
    );
  }


}
