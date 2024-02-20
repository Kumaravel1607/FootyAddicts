// To parse this JSON data, do
//
//     final gameDetails = gameDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GameDetails gameDetailsFromJson(String str) =>
    GameDetails.fromJson(json.decode(str));

String gameDetailsToJson(GameDetails data) => json.encode(data.toJson());

class GameDetails {
  GameDetails({
    required this.id,
    required this.stadiumId,
    required this.date,
    required this.time,
    required this.gameTittle,
    required this.maxPlayer,
    required this.rating,
    required this.description,
    required this.gameType,
    required this.game,
    required this.gender,
    required this.platformFee,
    required this.price,
    required this.payment,
    required this.cancellationPolicy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.stadiumName,
    required this.stadiumImage,
    required this.address,
    required this.grass,
    required this.countryName,
    required this.stateName,
    required this.couponCode,
  });

  int id;
  String stadiumId;
  String date;
  String time;
  String gameTittle;
  String maxPlayer;
  String rating;
  String description;
  String gameType;
  String game;
  String gender;
  String platformFee;
  String price;
  String payment;
  String cancellationPolicy;
  String status;
  String createdAt;
  String updatedAt;
  String stadiumName;
  String stadiumImage;
  String address;
  String grass;
  String countryName;
  String stateName;
  String couponCode;

  factory GameDetails.fromJson(Map<String, dynamic> json) => GameDetails(
        id: json["id"],
        stadiumId: json["stadium_id"] != null ? json["stadium_id"] : '',
        date: json["date"] != null ? json["date"] : '',
        time: json["time"] != null ? json["time"] : '',
        rating: json["rating"] != null ? json["rating"] : '',
        address: json["address"] != null ? json["address"] : '',
        grass: json['grass'] != null ? json["grass"] : '',
        gameTittle: json["game_tittle"] != null ? json["game_tittle"] : '',
        maxPlayer: json["max_player"] != null ? json["max_player"] : '',
        description: json["description"] != null ? json["description"] : '',
        gameType: json["game_type"] != null ? json["game_type"] : '',
        game: json["game"] != null ? json["game"] : '',
        gender: json["gender"] != null ? json["gender"] : '',
        price: json["price"] != null ? json["price"] : '',
        payment: json["payment"] != null ? json["payment"] : '',
        cancellationPolicy: json["cancellation_policy"] != null
            ? json["cancellation_policy"]
            : '',
        status: json["status"] != null ? json["status"] : '',
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        stadiumName: json["stadium_name"] != null ? json["stadium_name"] : '',
        stadiumImage: json["stadium_image"],
        //  != null ? json["stadium_image"] : '',
        countryName: json["country_name"] != null ? json["country_name"] : '',
        stateName: json["state_name"] != null ? json["state_name"] : '',
        platformFee: json["platform_fee"] != null ? json["platform_fee"] : '',
        couponCode: json["coupon_code"] != null ? json["coupon_code"] : '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stadium_id": stadiumId,
        "date": date.toString(),
        "time": time,
        "game_tittle": gameTittle,
        "max_player": maxPlayer,
        "rating": rating,
        "description": description,
        "game_type": gameType,
        "game": game,
        "gender": gender,
        "price": price,
        "payment": payment,
        "cancellation_policy": cancellationPolicy,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "stadium_name": stadiumName,
        "stadium_image": stadiumImage,
        "address": address,
        "grass": grass,
        "country_name": countryName,
        "state_name": stateName,
        "coupon_code": couponCode,
        "platform_fee": platformFee
      };
}


// import 'package:meta/meta.dart';
// import 'dart:convert';

// Details detailsFromJson(String str) => Details.fromJson(json.decode(str));

// String detailsToJson(Details data) => json.encode(data.toJson());

// class Details {
//   Details(
//       {required this.id,
//       required this.stadiumId,
//       required this.date,
//       required this.time,
//       required this.gameTittle,
//       required this.maxPlayer,
//       required this.rating,
//       required this.description,
//       required this.gameType,
//       required this.game,
//       required this.gender,
//       required this.price,
//       required this.payment,
//       required this.cancellationPolicy,
//       required this.status,
//       required this.createdAt,
//       required this.updatedAt,
//       required this.stadiumName,
//       required this.stadiumImage,
//       required this.address,
//       required this.grass,
//       required this.countryName,
//       required this.stateName,
//       required this.platformFee,
//       required this.couponCode});

//   int id;
//   String stadiumId;
//   String date;
//   String time;
//   String gameTittle;
//   String maxPlayer;
//   String rating;
//   String description;
//   String gameType;
//   String game;
//   String gender;
//   String price;
//   String payment;
//   String cancellationPolicy;
//   String status;
//   String createdAt;
//   String updatedAt;
//   String stadiumName;
//   String stadiumImage;
//   String address;
//   String grass;
//   String countryName;
//   String stateName;
//   String couponCode;
//   String platformFee;

//   factory Details.fromJson(Map<String, dynamic> json) => Details(
//         id: json["id"],
//         stadiumId: json["stadium_id"] != null ? json["stadium_id"] : '',
//         date: json["date"] != null ? json["date"] : '',
//         time: json["time"] != null ? json["time"] : '',
//         rating: json["rating"] != null ? json["rating"] : '',
//         address: json["address"] != null ? json["address"] : '',
//         grass: json['grass'] != null ? json["grass"] : '',
//         gameTittle: json["game_tittle"] != null ? json["game_tittle"] : '',
//         maxPlayer: json["max_player"] != null ? json["max_player"] : '',
//         description: json["description"] != null ? json["description"] : '',
//         gameType: json["game_type"] != null ? json["game_type"] : '',
//         game: json["game"] != null ? json["game"] : '',
//         gender: json["gender"] != null ? json["gender"] : '',
//         price: json["price"] != null ? json["price"] : '',
//         payment: json["payment"] != null ? json["payment"] : '',
//         cancellationPolicy: json["cancellation_policy"] != null
//             ? json["cancellation_policy"]
//             : '',
//         status: json["status"] != null ? json["status"] : '',
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         stadiumName: json["stadium_name"] != null ? json["stadium_name"] : '',
//         stadiumImage: json["stadium_image"],
//         //  != null ? json["stadium_image"] : '',
//         countryName: json["country_name"] != null ? json["country_name"] : '',
//         stateName: json["state_name"] != null ? json["state_name"] : '',
//         platformFee: json["platform_fee"] != null ? json["platform_fee"] : '',
//         couponCode: json["coupon_code"] != null ? json["coupon_code"] : '',
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "stadium_id": stadiumId,
//         "date": date.toString(),
//         "time": time,
//         "game_tittle": gameTittle,
//         "max_player": maxPlayer,
//         "rating": rating,
//         "description": description,
//         "game_type": gameType,
//         "game": game,
//         "gender": gender,
//         "price": price,
//         "payment": payment,
//         "cancellation_policy": cancellationPolicy,
//         "status": status,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "stadium_name": stadiumName,
//         "stadium_image": stadiumImage,
//         "address": address,
//         "grass": grass,
//         "country_name": countryName,
//         "state_name": stateName,
//         "coupon_code": couponCode.toString(),
//         "platform_fee": platformFee
//       };
// }
