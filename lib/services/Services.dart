import 'dart:convert' as convert;
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:footyaddicts/api/api.dart';
import 'package:footyaddicts/forgot.dart/otp.dart';
import 'package:footyaddicts/models/Editprofile.dart';
import 'package:footyaddicts/models/Stadium_list.dart';
import 'package:footyaddicts/models/details.dart';
import 'package:footyaddicts/models/game_gender.dart';
import 'package:footyaddicts/models/gametype.dart';

import 'package:footyaddicts/models/home_page.dart';
import 'package:footyaddicts/models/player.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  static Future<List<Datum>> fetchHome(date) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var email = _pref.getString("email");

    List<Datum> list = [];

    Map data = {'date': date.toString()};
    print('-----xxx----');
    // print(data);
    var url = Home;
    var urlparse = Uri.parse(url);

    final response = await http.post(
      urlparse,
    );
    print(urlparse);

    // list = DatumResponse(response.body);
    var responseBody = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      print(responseBody);
      list = DatumResponse(jsonEncode(responseBody['data']));

      // print(list);
      return list;
    } else {
      throw Exception("Problem in fetching ");
    }
    // return list;
  }

  static List<Datum> DatumResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Datum>((json) => Datum.fromJson(json)).toList();
  }

  static Future<List<Gender>> fetchgender() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var url = game_gender;
    var urlparse = Uri.parse(url);

    final response = await http.get(urlparse);
    print(urlparse);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> jsonResponse = map["data"];
      return jsonResponse.map((data) => new Gender.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static List<GameType> GameTypeResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<GameType>((json) => GameType.fromJson(json)).toList();
  }

  static Future<List<EditProfile>> edit() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var email = _pref.getString("email");
    List<EditProfile> list = [];
    var map = Map<String, dynamic>();
    var url = Edit_profile;
    var urlparse = Uri.parse(url);

    final response = await http.get(urlparse);
    print(urlparse);

    // list = DatumResponse(response.body);
    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = EditProfileResponse(jsonEncode(responseBody['data']));
      // print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching ");
    }
    // return list;
  }

  static List<EditProfile> EditProfileResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<EditProfile>((json) => EditProfile.fromJson(json))
        .toList();
  }

  static Future<List<StadiumList>> stadium() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var email = _pref.getString("email");
    var std = _pref.getInt('stadium_id');

    List<StadiumList> list = [];
    var map = Map<String, dynamic>();
    Map data = {'date': std.toString()};
    var url = Stadium_list;
    var urlparse = Uri.parse(url);

    final response = await http.post(urlparse);
    print(urlparse);

    // list = DatumResponse(response.body);
    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = StadiumListResponse(jsonEncode(responseBody['data']));
      // print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching ");
    }
    // return list;
  }

  static List<StadiumList> StadiumListResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<StadiumList>((json) => StadiumList.fromJson(json))
        .toList();
  }

  // static Future<Details> details(String id) async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   var id = _pref.getString("stadium_id");
  //   var email = _pref.getString("email");

  //   Map data = {"id": id};
  //   print(data);
  //   var url = Game_detail;
  //   var urlparse = Uri.parse(url);

  //   var response = await http.post(urlparse, body: data);

  //   print(urlparse);

  //   var userDetail = (json.decode(response.body));
  //   print(jsonDecode(response.body));
  //   if (jsonDecode(response.body) == "false") {
  //     throw Exception('Failed to load post');
  //   } else {
  //     return Details.fromJson(userDetail);
  //   }
  // }

  // static Future play() async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   // var email = _pref.getString("email");
  //   var id = _pref.getInt('stadium_id');

  //   Map data = {'id': id.toString()};
  //   var url = Game_player;
  //   var urlparse = Uri.parse(url);

  //   final response = await http.post(urlparse, body: data);
  //   print(urlparse);

  //   // list = DatumResponse(response.body);

  //   if (response.statusCode == 200) {
  //     final responseBody = json.decode(response.body);
  //     print(responseBody);

  //     // print(list);

  //   } else {
  //     print(response.statusCode);
  //     throw Exception("Problem in fetching ");
  //   }
  //   // return list;
  // }

  // static List<Playerlist> PlayerlistResponse(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<Playerlist>((json) => Playerlist.fromJson(json)).toList();
  // }

  static Future<List<Playerlist>> player() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var email = _pref.getString("email");
    var stadium_id = _pref.getString('stadium_id');

    List<Playerlist> list = [];
    var map = Map<String, dynamic>();
    Map data = {'stadium_id': stadium_id.toString()};
    print(data);
    var url = Player;
    var urlparse = Uri.parse(url);

    final response = await http.post(urlparse, body: data);
    print(urlparse);

    // list = DatumResponse(response.body);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      print(responseBody);
      list = PlayerlistResponse(jsonEncode(responseBody['data']));

      // print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching ");
    }
    // return list;
  }

  static List<Playerlist> PlayerlistResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Playerlist>((json) => Playerlist.fromJson(json)).toList();
  }
}
