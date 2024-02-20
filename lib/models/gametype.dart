// To parse this JSON data, do
//
//     final datum = datumFromJson(jsonString);

import 'dart:convert';

List<GameType> GameTypeFromJson(String str) =>
    List<GameType>.from(json.decode(str).map((x) => GameType.fromJson(x)));

String GameTypeToJson(List<GameType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GameType {
  GameType({
    required this.id,
    required this.gameType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String gameType;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory GameType.fromJson(Map<String, dynamic> json) => GameType(
        id: json["id"],
        gameType: json["game_type"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "game_type": gameType,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
