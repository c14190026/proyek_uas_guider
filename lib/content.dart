// ignore_for_file: camel_case_types

class contentDatabase {
  final String contentName;
  final String contentLink;

  contentDatabase({required this.contentName, required this.contentLink});

  Map<String, dynamic> tojson() {
    return {
      'contentName': contentName,
      'contentPic': contentLink,
    };
  }

  factory contentDatabase.fromJson(Map<String, dynamic> json) {
    return contentDatabase(
      contentName: json['title'],
      contentLink: json['link'],
    );
  }
}
