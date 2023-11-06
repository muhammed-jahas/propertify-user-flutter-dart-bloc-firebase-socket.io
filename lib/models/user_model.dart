class UserModel {
  String? id;
  String? username;
  String? userpassword;
  String? usermobNo;
  String? useremail;
  // String? userprofile;
  bool? isLogin;
  List<String>? requests;
  List<String>? favourites;

  UserModel({
    this.id,
    this.username,
    this.userpassword,
    this.usermobNo,
    this.useremail,
    // this.userprofile,
    this.isLogin,
    this.requests,
    this.favourites,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      username: json['username'],
      userpassword: json['userpassword'],
      usermobNo: json['usermobNo'],
      useremail: json['useremail'],
      // userprofile: json['userprofile'],
      isLogin: json['isLogin'],
      requests: List<String>.from(json['requests']),
      favourites: List<String>.from(json['favourites']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'username': username,
      'userpassword': userpassword,
      'usermobNo': usermobNo,
      'useremail': useremail,
      // 'userprofile': userprofile,
      'isLogin': isLogin,
      'requests': requests,
      'favourites': favourites,
    };

    data['_id'] = id;

    return data;
  }
}