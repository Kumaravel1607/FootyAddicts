import 'dart:async';
import 'dart:convert';
import 'package:email_auth/email_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footyaddicts/api/api.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/forgot.dart/resetpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:email_otp/email_otp.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import 'package:footyaddicts/testotp.dart';

bool _isResendAgain = false;
bool focus = false;

class OtpScreen extends StatefulWidget {
  // final String forgetemail;

  final String forgetemail;
  // final String checkotp;

  OtpScreen({
    Key? key,
    required this.forgetemail,
    // required this.checkotp,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

// List<TextEditingController> otp = [
//   TextEditingController(),
//   TextEditingController(),
//   TextEditingController(),
//   TextEditingController(),
//   TextEditingController(),
//   TextEditingController()
// ];

final TextEditingController otp = new TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController email = new TextEditingController();

class _OtpScreenState extends State<OtpScreen> {
  int start = 30;
  late Timer timer;
  // late String _code;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  void check_otp() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var Email = _pref.getString("email");
    Map data = {
      'email': widget.forgetemail,
      'otp': otp.text,
    };
    var url = CheckOtp;
    var urlparse = Uri.parse(url);

    print(data);
    print(urlparse);

    var response = await http.post(urlparse, body: data);

    var jsonResponse = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResetScreen(
                    email: widget.forgetemail,
                  )));
      // print('Sucessfull');

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(jsonResponse['message'].toString()),
        backgroundColor: Colors.red.shade300,
      ));
    }

    // if (response.statusCode == 200) {
    //   jsonResponse = json.decode(response.body.toString());
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => ResetScreen()));

    //   if (jsonResponse != null) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //     print(jsonResponse['message']);
    //   }
    // } else {
    //   jsonResponse = json.decode(response.body);
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   print(jsonResponse['message']);
    // }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 3,
          shadowColor: grey,
          titleSpacing: -11,
          title: const Text(
            "Enter OTP",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'IBMPlexSans',
                color: black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                  child: Text(
                    "An OTP has been sent to your registered mobile phone number ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'NunitoSans',
                        fontStyle: FontStyle.normal,
                        color: black),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: PinCodeTextField(
                    appContext: context,
                    // pastedTextStyle: TextStyle(
                    //   color: Colors.green.shade600,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    length: 4,
                    obscureText: false,
                    // animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(14),
                        fieldHeight: 50,
                        fieldWidth: 70,
                        inactiveFillColor: Colors.white,
                        inactiveColor: grey,
                        selectedColor: red,
                        selectedFillColor: Colors.white,
                        activeFillColor: Colors.white,
                        activeColor: red),
                    // cursorColor: Colors.black,
                    // animationDuration: Duration(milliseconds: 300),
                    // enableActiveFill: true,
                    controller: otp,
                    keyboardType: TextInputType.number,
                    // boxShadows: [
                    //   BoxShadow(
                    //     offset: Offset(0, 1),
                    //     color: Colors.black12,
                    //     blurRadius: 10,
                    //   )
                    // ],
                    onCompleted: (v) {
                      //do something or move to next screen when code complete
                    },
                    onChanged: (value) {
                      // print(value);
                      setState(() {
                        // print('$value');
                      });
                    },
                  ),
                ),

                // OtpTextField(
                //   numberOfFields: 4,
                //   borderColor: grey,
                //   showFieldAsBox: true,
                //   focusedBorderColor: red,
                //   borderRadius: BorderRadius.all(Radius.circular(10)),
                //   borderWidth: 2.0,
                //   fieldWidth: 73,
                // ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     SizedBox(
                //       height: 52,
                //       width: 73,
                //       child: TextField(
                //         controller: otp[0],
                //         onChanged: (value) {
                //           if (value.length == 1) {
                //             FocusScope.of(context).nextFocus();
                //           }
                //         },
                //         decoration: InputDecoration(
                //             enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(14),
                //               borderSide: const BorderSide(
                //                 color: grey,
                //               ),
                //             ),
                //             focusedBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(14),
                //               borderSide:
                //                   const BorderSide(color: red, width: 2),
                //             ),
                //             border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(14)),
                //             filled: true,
                //             fillColor: Colors.white),
                //         style: Theme.of(context).textTheme.headline5,
                //         keyboardType: TextInputType.number,
                //         textAlign: TextAlign.center,
                //         textInputAction: TextInputAction.next,
                //         inputFormatters: [
                //           LengthLimitingTextInputFormatter(1),
                //           FilteringTextInputFormatter.digitsOnly,
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       height: 52,
                //       width: 73,
                //       child: TextField(
                //         controller: otp[1],
                //         onChanged: (value) {
                //           if (value.length == 1) {
                //             FocusScope.of(context).nextFocus();
                //           }
                //         },
                //         decoration: InputDecoration(
                //             enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(14),
                //               borderSide: const BorderSide(
                //                 color: grey,
                //               ),
                //             ),
                //             focusedBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(14),
                //               borderSide:
                //                   const BorderSide(color: red, width: 2),
                //             ),
                //             border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(14)),
                //             filled: true,
                //             fillColor: Colors.white),
                //         style: Theme.of(context).textTheme.headline5,
                //         keyboardType: TextInputType.number,
                //         textAlign: TextAlign.center,
                //         textInputAction: TextInputAction.next,
                //         inputFormatters: [
                //           LengthLimitingTextInputFormatter(1),
                //           FilteringTextInputFormatter.digitsOnly,
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       height: 52,
                //       width: 73,
                //       child: TextField(
                //         controller: otp[2],
                //         onChanged: (value) {
                //           if (value.length == 1) {
                //             FocusScope.of(context).nextFocus();
                //           }
                //         },
                //         decoration: InputDecoration(
                //             enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(14),
                //               borderSide: const BorderSide(
                //                 color: grey,
                //               ),
                //             ),
                //             focusedBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(14),
                //               borderSide:
                //                   const BorderSide(color: red, width: 2),
                //             ),
                //             border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(14)),
                //             filled: true,
                //             fillColor: Colors.white),
                //         style: Theme.of(context).textTheme.headline5,
                //         keyboardType: TextInputType.number,
                //         textAlign: TextAlign.center,
                //         textInputAction: TextInputAction.next,
                //         inputFormatters: [
                //           LengthLimitingTextInputFormatter(1),
                //           FilteringTextInputFormatter.digitsOnly,
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       height: 52,
                //       width: 73,
                //       child: TextField(
                //         controller: otp[3],
                //         onChanged: (value) {
                //           if (value.length == 1) {
                //             FocusScope.of(context).nextFocus();
                //           }
                //         },
                //         decoration: InputDecoration(
                //             enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(14),
                //               borderSide: const BorderSide(
                //                 color: grey,
                //               ),
                //             ),
                //             focusedBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(14),
                //               borderSide:
                //                   const BorderSide(color: red, width: 2),
                //             ),
                //             border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(14)),
                //             filled: true,
                //             fillColor: Colors.white),
                //         style: Theme.of(context).textTheme.headline5,
                //         keyboardType: TextInputType.number,
                //         textAlign: TextAlign.center,
                //         textInputAction: TextInputAction.done,
                //         inputFormatters: [
                //           LengthLimitingTextInputFormatter(1),
                //           FilteringTextInputFormatter.digitsOnly,
                //         ],
                //       ),
                //     ),
                //   ],
                // ),

                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "Resend code in",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'NunitoSans',
                              fontStyle: FontStyle.normal,
                              color: black)),
                      TextSpan(
                          text: "  00: $start ",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'NunitoSans',
                              fontStyle: FontStyle.normal,
                              color: red)),
                      const TextSpan(
                          text: "seconds",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'NunitoSans',
                              fontStyle: FontStyle.normal,
                              color: black))
                    ])),
                  ),
                ),
                const SizedBox(
                  height: 450,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                      backgroundColor: red,
                      minimumSize: const Size.fromHeight(44),
                    ),
                    onPressed: () {
                      check_otp();
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => ResetScreen()));
                    },
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void startTimer() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);
    timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        if (start == 0) {
          start = 30;
          _isResendAgain = false;
          timer.cancel();
        } else {
          start--;
        }
      });
    });
  }
}
