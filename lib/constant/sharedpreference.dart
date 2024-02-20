import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static late SharedPreferences _preferences;

  static const _keyemail = 'email';
  static const _keyUsername = 'username';
  static const _keymobile = 'mobile';
  static const _keytoken = 'token';
  static const _Name = 'name';
  static const _Otp = 'otp';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String Username) async =>
      await _preferences.setString(_keyUsername, Username);

  static getUsername() => _preferences.getString(_keyUsername);

  static Future setemail(String email) async =>
      await _preferences.setString(_keyemail, email);

  static getemail() => _preferences.getString(_keyemail);

  static Future settoken(String token) async =>
      await _preferences.setString(_keytoken, token);

  static gettoken() => _preferences.getString(_keytoken);

  static Future setmobile(String mobile) async =>
      await _preferences.setString(_keymobile, mobile);

  static getmobile() => _preferences.getString(_keymobile);

  static Future setFirstname(String name) async =>
      await _preferences.setString(_Name, name);

  static getFirstname() => _preferences.getString(_Name);

  static Future setotp(String otp) async =>
      await _preferences.setString(_Otp, otp);

  static getotp() => _preferences.getString(_Otp);
}
