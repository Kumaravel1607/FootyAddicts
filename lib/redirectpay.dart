import 'package:flutter/material.dart';
import 'package:footyaddicts/constant/color.dart';

class Redirect extends StatefulWidget {
  Redirect({Key? key}) : super(key: key);

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Player will be redirected to payment gateway to complete the payment .',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w400,
              fontFamily: 'NunitoSans',
              color: black),
        ),
      )),
    );
  }
}
