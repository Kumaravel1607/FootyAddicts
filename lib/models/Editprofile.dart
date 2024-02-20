// To parse this JSON data, do
//
//     final editProfile = editProfileFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<EditProfile> editProfileFromJson(String str) => List<EditProfile>.from(
    json.decode(str).map((x) => EditProfile.fromJson(x)));

String editProfileToJson(List<EditProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EditProfile {
  EditProfile({
    required this.id,
    required this.userType,
    required this.image,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.password,
    required this.otp,
    required this.mobile,
    required this.gender,
    required this.dob,
    required this.about,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  int? userType;
  String image;
  String fullName;
  String userName;
  String email;
  String password;
  String otp;
  String mobile;
  String gender;
  String dob;
  String about;
  String status;
  String createdAt;
  String updatedAt;

  factory EditProfile.fromJson(Map<String, dynamic> json) => EditProfile(
        id: json["id"],
        userType: json["user_type"],
        image: json["image"] != null ? json["image"] : '',
        fullName: json["full_name"] != null ? json["full_name"] : '',
        userName: json["user_name"] != null ? json["user_name"] : '',
        email: json["email"] != null ? json["email"] : '',
        password: json["password"] != null ? json["password"] : '',
        otp: json["otp"] != null ? json["otp"] : '',
        mobile: json["mobile"] != null ? json["mobile"] : '',
        gender: json["gender"] != null ? json["gender"] : '',
        dob: json["dob"] != null ? json["dob"] : '',
        // json["key1"] == null ? null : json["key1"]
        about: json["about"] == null ? null : json["about"],
        status: json["status"] != null ? json["status"] : '',
        createdAt: json["created_at"] != null ? json["created_at"] : '',
        updatedAt: json["updated_at"] != null ? json["updated_at"] : '',
      );

  //   id: json["id"],
  //   userType: json["user_type"],
  //   image: json["image"] != null ? json["image"] : '',
  //   fullName: json["full_name"],
  //   userName: json["user_name"],
  //   email: json["email"],
  //   password: json["password"],
  //   otp: json["otp"],
  //   mobile: json["mobile"],
  //   gender: json["gender"],
  //   dob: json["dob"],
  //   about: json["about"],
  //   status: json["status"],
  //   createdAt: json["created_at"],
  //   updatedAt: json["updated_at"],
  // );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_type": userType.toString(),
        "image": image,
        "full_name": fullName,
        "user_name": userName,
        "email": email,
        "password": password,
        "otp": otp,
        "mobile": mobile,
        "gender": gender,
        "dob": dob,
        "about": about == null ? null : about,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
