import 'dart:async';

import 'package:flutter/material.dart';
import 'package:footyaddicts/Home_page.dart';
import 'package:footyaddicts/Navigation.dart';
import 'package:footyaddicts/home1.dart';
import 'package:footyaddicts/login.dart';
import 'package:footyaddicts/Signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Timer(
  //       const Duration(seconds: 2),
  //       () => Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => Navigation())));
  // }

  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () async {
      SharedPreferences session = await SharedPreferences.getInstance();
      var email = session.getString('email');
      // var mobile = session.getString('phone');
      // var token = session.getString('token');
      print("-------");
      print(email);
      if (email == null || email == "") {
        // if (token != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => LogScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Navigation()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Footy.png',
                height: 130,
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 15, 48, 12)),
                backgroundColor: Colors.white,
                strokeWidth: 1,
              )
            ],
          ),
        ),
      )),
    );
  }
}
