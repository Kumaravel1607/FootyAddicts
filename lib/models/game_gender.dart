// To parse this JSON data, do
//
//     final Gender = datumFromJson(jsonString);

import 'dart:convert';

List<Gender> GenderFromJson(String str) =>
    List<Gender>.from(json.decode(str).map((x) => Gender.fromJson(x)));

String GenderToJson(List<Gender> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Gender {
  Gender({
    required this.id,
    required this.gender,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String gender;
  String status;
  String createdAt;
  String updatedAt;

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        id: json["id"],
        gender: json["gender"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender": gender,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
