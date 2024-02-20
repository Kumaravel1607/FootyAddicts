import 'dart:convert';
import 'package:footyaddicts/Welcome.dart';
import 'package:footyaddicts/api/base.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:footyaddicts/Navigation.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/forgot.dart/forgotpassword.dart';
import 'package:footyaddicts/home.dart';
import 'package:footyaddicts/Signin.dart';
import 'package:http/http.dart';

class LogScreen extends StatefulWidget {
  // final Function(bool) callback;
  const LogScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  // late Welcome baseModel;

  // @override
  // void initState() {
  //   baseModel = new Welcome(
  //     email: 'email',
  //     mobile: 'mobile',
  //     name: 'name',
  //     password: 'password',
  //     profileImage: 'profileImage',
  //     token: 'token',
  //   ); // TODO: implement initState
  //   super.initState();
  // }

  bool? _checkbox = false;
  late String _email;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();
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
                  height: 215,

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
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'IBMPlexSans',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 28,
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
                          // onSaved: (input) => baseModel.email = input!,
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
                          // obscureText: true,
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
                                fontFamily: 'Rubik', color: grey, fontSize: 14),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: IconTheme(
                                data: IconThemeData(
                                  color: secondary,
                                ),
                                child: Icon(
                                  Icons.visibility_off,
                                  color: grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                activeColor: red,
                                value: _checkbox,
                                onChanged: (val) {
                                  setState(() {
                                    _checkbox = val;
                                  });
                                }),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22)),
                            backgroundColor: red,
                            minimumSize: const Size.fromHeight(44),
                          ),
                          onPressed: () {
                            user();
                            // if (formkey.currentState!.validate()) {
                            //   Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => Navigation()));
                            // } else {}
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotScreen()));
                              },
                              child: const Text(
                                'Forget password?',
                                style: TextStyle(
                                    color: red,
                                    fontSize: 16,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                              )),
                        ),
                        const SizedBox(
                          height: 8,
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
                          height: 20,
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
                          height: 25,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                            },
                            child: Center(
                              child: RichText(
                                text: const TextSpan(
                                    text: " Don't have an account?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' Sign up here',
                                        style: TextStyle(
                                            color: red,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontStyle: FontStyle.normal),
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

  // _register() async {
  //   var data = {
  //     'email': email.text,
  //     'password': pass.text,
  //   };
  //   // var response = await API().postData(data, 'login');
  // }
  void user() async {
    var url = 'http://192.168.29.242:80/api/login';
    var data = {
      // "name":name.text,
      "email": email.text,
      "password": pass.text,
    };

    var body = json.encode(data);
    var urlparse = Uri.parse(url);

    Response response = await http.post(
      urlparse,
      body: data,
      // headers: _setHeaders(),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Navigation()));
      print('Sucessfull');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid Email and password'),
        backgroundColor: Colors.red.shade300,
      ));
      print('Fa');
    }
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
