import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:footyaddicts/api/api.dart';
import 'package:footyaddicts/Navigation.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/home.dart';
import 'package:footyaddicts/home1.dart';
import 'package:footyaddicts/login.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passVisibility = true;
  late String _email, _name;
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Container(
                  width: width,

                  // height: MediaQuery.of(context).size.height * .22,
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: tab, width: 0.3))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 21, left: 83, right: 83),
                    child: Image.asset(
                      'assets/images/Footy.png',
                      height: 194,
                      width: 194,
                    ),
                  ),

                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'FOOTY',
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w900, fontSize: 18),
                  //     ),
                  //     Text(
                  //       'CONNECT',
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w400, fontSize: 18),
                  //     ),
                  //   ],
                  // ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Sign Up for FREE!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'IBMPlexSans',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Rubik'),
                            ),
                            Text(
                              'Use phone',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: red,
                                fontFamily: 'Rubik',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter email";
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          // onSaved: (email) {
                          //   _email = email!;
                          // },
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(color: red, width: 2)),
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
                            hintText: 'Enter your email',
                            hintStyle: const TextStyle(
                                color: grey, fontFamily: 'Rubik', fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Password',
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
                          // onSaved: (input) => baseModel.password = input!,
                          controller: pass,
                          autocorrect: true,
                          obscureText: _passVisibility,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide(color: red, width: 2)),
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
                              hintText: 'Enter your password',
                              hintStyle: const TextStyle(
                                  fontFamily: 'Rubik',
                                  color: grey,
                                  fontSize: 14),
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
                              )
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
                              ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Full Name',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik'),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter name";
                            }
                            return null;
                          },
                          // onSaved: (name) {
                          //   _name = name!;
                          // },
                          controller: name,
                          autocorrect: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(color: red, width: 2)),
                            contentPadding: const EdgeInsets.only(
                                left: 24, top: 14, bottom: 13),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: const BorderSide(
                                color: grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide:
                                  const BorderSide(color: red, width: 2),
                            ),

                            filled: true,
                            fillColor: Colors.white,

                            hintText: 'Enter your full name',
                            hintStyle: const TextStyle(
                                color: grey, fontFamily: 'Rubik', fontSize: 14),
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(24),
                            //   borderSide: BorderSide(
                            //     color: grey,
                            //   ),
                            // ),
                            // prefixIcon: IconTheme(
                            //   data: IconThemeData(
                            //     color: secondary,
                            //   ),
                            //   child: Icon(Icons.email),
                            // ),
                          ),
                        ),
                        const SizedBox(
                          height: 34,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22)),
                            backgroundColor: red,
                            minimumSize: const Size.fromHeight(44),
                          ),
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              user();
                            }
                            // if (formkey.currentState!.validate()) {
                            //   Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => HomeScreen()));
                            // } else {}
                          },
                          // onPressed: () {
                          //   // Navigator.of(context).push(
                          //   //     MaterialPageRoute(builder: (context) => HomeScreen()));
                          // },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        Row(children: const <Widget>[
                          Expanded(
                              child: Divider(
                            indent: 10.0,
                            endIndent: 10.0,
                            thickness: 1,
                            color: grey,
                          )),
                          Text(
                            'or Continue with',
                            style: TextStyle(
                                color: grey, fontFamily: 'Rubik', fontSize: 16),
                          ),
                          Expanded(
                              child: Divider(
                            indent: 10.0,
                            endIndent: 10.0,
                            thickness: 1,
                            color: grey,
                          )),
                        ]),
                        const SizedBox(
                          height: 36,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    side: const BorderSide(
                                        style: BorderStyle.solid,
                                        color: grey,
                                        width: 1),
                                    backgroundColor: white,
                                    foregroundColor: black,
                                    fixedSize: const Size(158, 44),
                                    elevation: 0),
                                onPressed: () {
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(builder: (context) => HomeScreen()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/google.png',
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text("Google",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Rubik',
                                            fontSize: 16))
                                  ],
                                )),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    side: const BorderSide(
                                        style: BorderStyle.solid,
                                        color: grey,
                                        width: 1),
                                    backgroundColor: white,
                                    foregroundColor: black,
                                    fixedSize: const Size(158, 44),
                                    elevation: 0),
                                onPressed: () {
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(builder: (context) => HomeScreen()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 13.02, bottom: 14),
                                      child: Image.asset(
                                        'assets/images/ap.png',
                                        height: 16.99,
                                        width: 14.33,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.5,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 13, bottom: 12),
                                      child: Text("Apple",
                                          style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16)),
                                    )
                                  ],
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        TextButton(
                            onPressed: () {
                              //   Navigator.of(context).push(MaterialPageRoute(
                              //       builder: (context) => LogScreen()));
                            },
                            child: Center(
                              child: RichText(
                                text: const TextSpan(
                                    text: ' Already have an account?',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' Login',
                                        style: TextStyle(
                                          color: red,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      )
                                    ]),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  user() async {
    var jsonResponse;
    var data = {
      'email': email.text,
      'full_name': name.text,
      'password': pass.text,
    };
    print(data);
    var url = 'http://192.168.29.242:8000/api/register';
    // var url = api_url + 'register';
    // var url = Register;
    var urlparse = Uri.parse(url);
    var body = json.encode(data);

    var response = await http.post(
      urlparse,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );

    print(response.body);
    print(response.statusCode);
    var response_data = json.decode(response.body.toString());
    print(response_data);
    if (response.statusCode == 200) {
      print(response_data['user_id']);
      print(response_data['email']);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Navigation()));
      print('Sucessfull');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response_data['message']),
        backgroundColor: Colors.red.shade300,
      ));
      print('Error');
    }
  }

  //   if (response.statusCode == 200) {
  //     Response = json.decode(response.body.toString());
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(" ${jsonResponse['Message']}")));

  //     //Or put here your next screen using Navigator.push() method
  //     print('success');
  //   } else {
  //     print('error');
  //   }
  // }

  // void user() async {
  //   var url = api_url + 'register';
  //   var data = {
  //     "full_name": name.text,
  //     "email": email.text,
  //     "password": pass.text,
  //   };

  //   var body = json.encode(data);
  //   var urlparse = Uri.parse(url);

  //   Response response = await http.post(
  //     urlparse,
  //     body: data,
  //     // headers: _setHeaders(),
  //   );
  //   var response_data = json.decode(response.body.toString());
  //   print(response_data);
  //   if (response.statusCode == 200) {
  //     print(response_data['user_id']);
  //     print(response_data['email']);
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => LoginScreen()));
  //     print('Sucessfull');
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(response_data['message']),
  //       backgroundColor: Colors.red.shade300,
  //     ));
  //     print('Error');
  //   }
  // }

  // _setHeaders() => {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //     };
}
