// To parse this JSON data, do
//
//     final playerlist = playerlistFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// List<Playerlist> playerlistFromJson(String str) =>
//     List<Playerlist>.from(json.decode(str).map((x) => Playerlist.fromJson(x)));

// String playerlistToJson(List<Playerlist> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Playerlist {
//   Playerlist({
//     required this.userName,
//     required this.image,
//     required this.profileImage,
//   });

//   String userName;
//   String image;
//   String profileImage;

//   factory Playerlist.fromJson(Map<String, dynamic> json) => Playerlist(
//         userName: json["user_name"] != null ? json["user_name"] : '',
//         image: json["image"] != null ? json["image"] : '',
//         profileImage:
//             json["profile_image"] != null ? json["profile_image"] : '',
//       );

//   Map<String, dynamic> toJson() => {
//         "user_name": userName,
//         "image": image,
//         "profile_image": profileImage,
//       };
// }

// To parse this JSON data, do
//
//     final playerlist = playerlistFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Playerlist> playerlistFromJson(String str) =>
    List<Playerlist>.from(json.decode(str).map((x) => Playerlist.fromJson(x)));

String playerlistToJson(List<Playerlist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Playerlist {
  Playerlist({
    required this.userName,
    required this.image,
    required this.profileImage,
  });

  String userName;
  String image;
  String profileImage;

  factory Playerlist.fromJson(Map<String, dynamic> json) => Playerlist(
        userName: json["user_name"] != null ? json["user_name"] : '',
        image: json["image"] != null ? json["image"] : '',
        profileImage:
            json["profile_image"] != null ? json["profile_image"] : '',
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "image": image,
        "profile_image": profileImage,
      };
}
