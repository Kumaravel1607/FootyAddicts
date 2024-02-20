import 'package:flutter/material.dart';
import 'package:footyaddicts/constant/sharedpreference.dart';
// import 'package:footyaddicts/provider/google_signin.dart';
import 'package:footyaddicts/splash.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
  await SharedPreference.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // ChangeNotifierProvider(
        //   create: (context) => GoogleSignInProvider(),
        //   child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.blueGrey,
        primarySwatch: Colors.blue,
        // fontFamily: 'Montserrat',
        textTheme: TextTheme(),
      ),
      home: SplashScreen(),
      // home: Location()
      // home: AddPage_02(),
      // home: LogScreen(),
      // ),
    );
  }
}
