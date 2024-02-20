// To parse this JSON data, do
//
//     final stadiumList = stadiumListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<StadiumList> stadiumListFromJson(String str) => List<StadiumList>.from(
    json.decode(str).map((x) => StadiumList.fromJson(x)));

String stadiumListToJson(List<StadiumList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StadiumList {
  StadiumList({
    required this.id,
    required this.stadiumName,
    required this.stadiumImage,
    required this.countryId,
    required this.stateId,
    required this.address,
    required this.grass,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String stadiumName;
  String stadiumImage;
  String countryId;
  String stateId;
  String address;
  String grass;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory StadiumList.fromJson(Map<String, dynamic> json) => StadiumList(
        id: json["id"],
        stadiumName: json["stadium_name"],
        stadiumImage: json["stadium_image"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        address: json["address"],
        grass: json["grass"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stadium_name": stadiumName,
        "stadium_image": stadiumImage,
        "country_id": countryId,
        "state_id": stateId,
        "address": address,
        "grass": grass,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
