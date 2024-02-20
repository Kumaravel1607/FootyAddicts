// // To parse this JSON data, do
// //
// //     final datum = datumFromJson(jsonString);

// import 'dart:convert';

// List<Datum> datumFromJson(String str) =>
//     List<Datum>.from(json.decode(str).map((x) => Datum.fromJson(x)));

// String datumToJson(List<Datum> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Datum {
//   Datum({
//     required this.id,
//     required this.stadiumId,
//     required this.date,
//     required this.time,
//     required this.gameTittle,
//     required this.maxPlayer,
//     required this.rating,
//     required this.description,
//     required this.gameType,
//     required this.game,
//     required this.gender,
//     required this.price,
//     required this.payment,
//     required this.cancellationPolicy,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.stadiumName,
//     required this.stadiumImage,
//     required this.countryName,
//     required this.stateName,
//   });

//   int id;
//   String stadiumId;
//   String date;
//   String time;
//   String gameTittle;
//   String maxPlayer;
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
//   String countryName;
//   String stateName;
//   String rating;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         rating: json["rating"],
//         id: json["id"],
//         stadiumId: json["stadium_id"] != null ? json["stadium_id"] : '',
//         date: json["date"],
//         time: json["time"],
//         gameTittle: json["game_tittle"],
//         maxPlayer: json["max_player"] != null ? json["max_player"] : '',
//         description: json["description"],
//         gameType: json["game_type"] != null ? json["game_type"] : '',
//         game: json["game"],
//         gender: json["gender"],
//         price: json["price"],
//         payment: json["payment"],
//         cancellationPolicy: json["cancellation_policy"] != null
//             ? json["cancellation_policy"]
//             : '',
//         status: json["status"] != null ? json["status"] : '',
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         stadiumName: json["stadium_name"] != null ? json["stadium_name"] : '',
//         stadiumImage: json["stadium_image"],
//         countryName: json["country_name"] != null ? json["country_name"] : '',
//         stateName: json["state_name"] != null ? json["state_name"] : '',
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "stadium_id": stadiumId,
//         "date": date,
//         "time": time,
//         "game_tittle": gameTittle,
//         "max_player": maxPlayer,
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
//         "country_name": countryName,
//         "state_name": stateName,
//         "rating": rating,
//       };
// }
