import 'dart:convert';

import 'package:footyaddicts/Welcome.dart';
import 'package:footyaddicts/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class API {
  // String baseurl = 'http://192.168.29.242:80/api/login';
  Future<User> login(User baseModel) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    var url = Uri.parse(Login);
    final response = await http.post(
      url,
      body: baseModel.toJson(),
      headers: _setHeaders(),
    );
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
      // var base = jsonDecode(response.body.toString());
      // print('Sucessfull');
    } else {
      throw Exception('Failed');
      // print('failed');
    }
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}



// const String baseurl = 'http://192.168.29.242:80/api';

// class base {
//   // var Client = http.Client();
//   Future<dynamic> login(base, api) async {
//     var url = Uri.parse(baseurl + api);
//     var response = await http.post(
//       url,
//       body: jsonEncode(base),
//       headers: _setHeaders(),
//     );
//     if (response.statusCode == 200) {
//       return base.fromJson(json.decode(response.body));
//       // var base = jsonDecode(response.body.toString());
//       // print('Sucessfull');
//     } else {
//       throw Exception('Failed');
//       // print('failed');
//     }
//   }

//   _setHeaders() => {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//       };
// }
