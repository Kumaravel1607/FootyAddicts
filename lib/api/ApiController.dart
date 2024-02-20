import 'dart:io';

import 'package:footyaddicts/api/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Service {
  static login(email, password) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    var url = Login;

    Map data = {
      "email": email,
      "password": password,
    };

    var body = json.encode(data);
    var urlparse = Uri.parse(url);
    Response response = await http.post(
      urlparse,
      body: data,
      // headers: _setHeaders(),
    );

    return data;
  }
}
