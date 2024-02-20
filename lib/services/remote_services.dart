import 'dart:convert';

import 'package:footyaddicts/api/API.dart';

import 'package:footyaddicts/models/home_page.dart';

import 'package:http/http.dart' as http;

class RemoteServices {
  static Future<List<Datum>> fetchHome() async {
    List<Datum> list = [];
    var map = Map<String, dynamic>();
    var url = Home;
    var urlparse = Uri.parse(url);

    final response = await http.get(urlparse);
    print(urlparse);
    list = WelcomeResponse(response.body);
    return list;
  }

  static List<Datum> WelcomeResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    print(responseBody);

    return parsed.map<Datum>((json) => Datum.fromJson(json)).toList();
  }

  // static Future<List<Datum>> fetchHome() async {
  //   // SharedPreferences _pref = await SharedPreferences.getInstance();
  //   // var token = _pref.getString("token");
  //   List<Welcome> list = [];
  //   Map data = {};
  //   var url = Home;
  //   var urlparse = Uri.parse(url);

  //   var response = await http.post(Uri.parse(url), body: data, headers: {
  //     'Authorization': 'Bearer '
  //     // $token',
  //   });

  //   // var responseBody = json.decode(response.body.toString());
  //   print(jsonDecode(response.body));
  //   if (response.statusCode == 200) {
  //     list = WelcomeResponse(jsonEncode(response.body['result']));
  //     print(list);
  //     return list;
  //   } else {
  //     print(response.statusCode);
  //     throw Exception("Problem in fetching List");
  //   }
  // }

  // static List<Welcome> WelcomeResponse(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<Welcome>((json) => Welcome.fromJson(json)).toList();
  // }
  // static Future<List<Welcome>> fetchHome(
  //   stadiumImage,
  // ) async {
  //   var url = Home;
  //   var urlparse = Uri.parse(url);

  //   var response = await http.get(urlparse);
  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     print(response);
  //     return (response as List).map((p) => Welcome.fromJson(p)).toList();
  //   } else {
  //     print(response.statusCode.toString());
  //     throw Exception(
  //         'Failed load data with status code ${response.statusCode}');
}
// catch(e){
//      print (e);
//      throw e;}

// static Future<List<Welcome>> fetchHome() async {
  //   // static Future<Welcome> fetchHome() async {

  //   var url = Home;
  //   var urlparse = Uri.parse(url);
  //   // var body = e.encode(data);
  //   // var url = 'http://myurl/home/djkjkfjkjfwkjfkwjkjfkjwjfkwjfkwf';
  //   var response = await http.get(urlparse);

  //   // final body = response.body;
  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     // final jsonResponse = jsonDecode(body.toString());
  //     // final welcome = (response_data as Map<String, dynamic>)['welcome'];
  //     // final users = welcome.map((e) {
  //     //   return Welcome.fromJson(e);
  //     // }).toList();

  //     // return users;
  //     return jsonResponse.map((welcome) => Welcome.fromJson(welcome)).toList();
  //   } else {
  //     throw Exception("failed");
  //   }