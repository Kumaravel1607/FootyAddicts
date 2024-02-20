// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

class User {
  User({
    required this.token,
    required this.userId,
    required this.profileImage,
    required this.name,
    required this.email,
    required this.mobile,
    // required this.password,
  });
  // String password;
  String token;
  int userId;
  String profileImage;
  String name;
  String email;
  String mobile;

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        userId: json["user_id"],
        profileImage: json["profile_image"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        // password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_id": userId,
        "profile_image": profileImage,
        "name": name,
        "email": email,
        "mobile": mobile,
        // "password": password
      };
}
