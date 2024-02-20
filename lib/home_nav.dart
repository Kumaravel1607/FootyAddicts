// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:footyaddicts/Navigation.dart';
// import 'package:footyaddicts/Signin.dart';

// class Nav_home extends StatefulWidget {
//   Nav_home({Key? key}) : super(key: key);

//   @override
//   State<Nav_home> createState() => _Nav_homeState();
// }

// class _Nav_homeState extends State<Nav_home> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasData) {
//             return Navigation();
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Something went Wrong!"));
//           } else {
//             return LoginScreen();
//           }
//         });
//   }
// }
