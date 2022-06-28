// ignore_for_file: camel_case_types

class userDatabase {
  final String userName;
  final String userEmail;
  final String userSubs;
  final String userPic;

  userDatabase(
      {required this.userName,
      required this.userEmail,
      required this.userSubs,
      required this.userPic});

  Map<String, dynamic> tojson() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'userSubs': userSubs,
      'userPic': userPic,
    };
  }

  factory userDatabase.fromJson(Map<String, dynamic> json) {
    return userDatabase(
      userName: json['userName'],
      userEmail: json['userEmail'],
      userSubs: json['userSubs'],
      userPic: json['userPic'],
    );
  }
}
