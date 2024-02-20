import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:footyaddicts/api/api.dart';
import 'package:footyaddicts/Navigation.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/forgot.dart/otp.dart';
import 'package:footyaddicts/login.dart';
import 'package:footyaddicts/Signin.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ResetScreen extends StatefulWidget {
  // final Function(bool) callback;
  final String email;
  ResetScreen({
    Key? key,
    // required TextEditingController forgotemail,
    required this.email,
  }) : super(key: key);

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  bool? _checkbox = false;
  bool _passVisibility1 = true;
  bool _passVisibility = true;
  // SharedPreferences sharedPreferences;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // final TextEditingController email = new TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // @override
  // void initState() {}

  // password_change(
  //   newPass,
  //   confirmPass,
  // ) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   Map data = {
  //     'email': widget.email,
  //     'new_password': newPass,
  //     'confirm_password': confirmPass,
  //   };

  //   print(data);
  //   var jsonResponse = null;
  //   var url = ResetPassword;
  //   var urlparse = Uri.parse(url);

  //   var response = await http.post(urlparse, body: data);
  //   // var response =
  //   //     await http.post(Uri.parse(app_api + "/new_password"), body: data);
  //   // jsonResponse = json.decode(response.body);

  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     if (jsonResponse != null) {
  //       setState(() {
  //         _checkbox = false;
  //       });
  //       _alerDialog(jsonResponse['message']);

  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (BuildContext context) => LogScreen()),
  //           (Route<dynamic> route) => false);
  //     }
  //   } else if (response.statusCode == 422) {
  //     jsonResponse = json.decode(response.body);
  //     setState(() {
  //       _checkbox = false;
  //     });
  //     _alerDialog(jsonResponse['message']);
  //     print("object");
  //   }
  // }

  // Future<void> _alerDialog(message) async {
  //   await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: Text(message),
  //           //title: Text(),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context, "ok");
  //               },
  //               child: const Text("OK"),
  //             )
  //           ],
  //         );
  //       });
  // }

  // Future<void> _alerBox() async {
  //   await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: Text("Password is not match"),
  //           //title: Text(),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context, "ok");
  //               },
  //               child: const Text("OK"),
  //             )
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.chevron_left, color: black)),
            backgroundColor: white,
            titleSpacing: -11,
            title: const Text(
              "Reset Password",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'IBMPlexSans',
                  color: black),
            )),
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              'Create New Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'NunitoSans',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          const Text(
                            'New Password',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Rubik'),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter password";
                              }

                              return null;
                            },
                            onSaved: (value) {},
                            controller: password,
                            keyboardType: TextInputType.text,
                            autocorrect: true,
                            obscureText: _passVisibility1,
                            // obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide:
                                        BorderSide(color: red, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(color: grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide:
                                      const BorderSide(color: red, width: 2),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 24, top: 14, bottom: 13),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter new password',
                                hintStyle: const TextStyle(
                                    color: grey,
                                    fontFamily: 'Rubik',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                // suffixIcon: const Padding(
                                //   padding: EdgeInsets.only(right: 10),
                                //   child: IconTheme(
                                //     data: IconThemeData(
                                //       color: secondary,
                                //     ),
                                //     child: Icon(
                                //       Icons.visibility_off,
                                //       color: grey,
                                //     ),
                                //   ),
                                // ),
                                suffixIcon: IconButton(
                                  color: grey,
                                  icon: _passVisibility1
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: grey,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: greylite,
                                        ),
                                  onPressed: () {
                                    _passVisibility1 = !_passVisibility1;
                                    setState(() {});
                                  },
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Confirm New Password',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Rubik'),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Please re-enter password";
                              }
                              if (password.text != confirmpassword.text) {
                                return "Password didn't match";
                              }

                              return null;
                            },
                            onSaved: (value) {},
                            controller: confirmpassword,
                            autocorrect: true,
                            keyboardType: TextInputType.text,
                            // obscureText: true,
                            obscureText: _passVisibility,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide:
                                        BorderSide(color: red, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(color: grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide:
                                      const BorderSide(color: red, width: 2),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 24, top: 14, bottom: 13),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter new password',
                                hintStyle: const TextStyle(
                                    fontFamily: 'Rubik',
                                    color: grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                // suffixIcon: const Padding(
                                //   padding: EdgeInsets.only(right: 10),
                                //   child: IconTheme(
                                //     data: IconThemeData(
                                //       color: secondary,
                                //     ),
                                //     child: Icon(
                                //       Icons.visibility_off,
                                //       color: grey,
                                //     ),
                                //   ),
                                // ),
                                suffixIcon: IconButton(
                                  color: grey,
                                  icon: _passVisibility
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: grey,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: greylite,
                                        ),
                                  onPressed: () {
                                    _passVisibility = !_passVisibility;
                                    setState(() {});
                                  },
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                      backgroundColor: red,
                      minimumSize: const Size.fromHeight(44),
                    ),
                    onPressed: () {
                      newpassword();
                      // if (formkey.currentState!.validate()) {
                      //   // formkey.currentState.save();
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => LogScreen()));
                      // } else {}
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void newpassword() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var Email = session.getString('email');
    var url = ResetPassword;
    var data = {
      "email": widget.email,
      "new_password": password.text,
      "confirm_password": confirmpassword.text
    };
    print(data);

    var body = json.encode(data);
    var urlparse = Uri.parse(url);

    Response response = await http.post(
      urlparse,
      body: data,
    );
    print(urlparse);
    var response_data = json.decode(response.body.toString());
    print(response_data);
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LogScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response_data['message'].toString()),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}
