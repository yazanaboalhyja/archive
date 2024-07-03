

class ActivityModel  {
  final dynamic ActivityObject;
  final String activityTypeImage;
  final String activityType;
  final String activitySummary;
  final String created_at;
  final String authorName;
  ActivityModel(
      {
        this.ActivityObject,
        required this.activityTypeImage,
        required this.activityType,
        required this.authorName,
        required this.created_at,
        required this.activitySummary,

      });

  Map<String, dynamic> toMap() {
    return {
      'activityTypeImage': activityTypeImage,
      'authorName' : authorName,
      'created_at': created_at,
      'activitySummary': activitySummary,
      'activityType': activityType,
      'ActivityObject': ActivityObject,
    };

  }
  Map<String, dynamic> toJson() {
    return {
      'ActivityObject' : ActivityObject,
      'activityTypeImage': activityTypeImage,
      'authorName' : authorName,
      'created_at': created_at,
      'activityType': activityType,
      'activitySummary': activitySummary,

    };

  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {


    return ActivityModel(
      ActivityObject: map['ActivityObject'] ?? '',
      activityTypeImage: map['activityTypeImage'] ?? '',
      authorName: map['authorName'] ?? '',
      activitySummary: map['activitySummary'] ?? '',
      created_at: map['created_at'] ?? '',
      activityType: map['activityType'] ?? '',

    );

  }

  factory  ActivityModel.fromJson(Map<String, dynamic> json) {


    return  ActivityModel(
      ActivityObject: json['ActivityObject'] ?? '',
      activityTypeImage: json['activityTypeImage'] ?? '',
      created_at: json['created_at'] ?? '',
      authorName: json['authorName'] ?? '',
      activitySummary: json['activitySummary'] ?? '',
      activityType: json['activityType'] ?? '',

    );
  }


}
