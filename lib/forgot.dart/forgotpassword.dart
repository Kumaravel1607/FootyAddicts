import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:footyaddicts/api/api.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/forgot.dart/otp.dart';
import 'package:email_auth/email_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  int? SelectedRadio;
  // bool focus = true;
  String selected = "first";

  @override
  void initState() {
    super.initState();
    SelectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      SelectedRadio = val;
    });
  }

  final TextEditingController email = TextEditingController();
  final TextEditingController otp = TextEditingController();
  String message = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 3,
        shadowColor: grey,
        titleSpacing: -11,
        title: const Text(
          "Forgot Password",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                  child: Text(
                    "Select which contact details should we use to reset your password",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'NunitoSans',
                        color: black),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      Text("Enter email"),
                      SizedBox(
                        height: 10,
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
                            borderSide: const BorderSide(color: red, width: 2),
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
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 16),
                //   child: Column(
                //     children: [
                //       GestureDetector(
                //         onTap: () {},
                //         child: Container(
                //             height: 70,
                //             decoration: BoxDecoration(
                //               border:
                //                   Border.all(width: 2, color: focus ? red : grey),
                //               borderRadius:
                //                   const BorderRadius.all(Radius.circular(14)),
                //             ),
                //             child: RadioListTile(
                //               contentPadding: EdgeInsets.zero,
                //               dense: true,
                //               visualDensity: const VisualDensity(
                //                 horizontal: VisualDensity.minimumDensity,
                //               ),
                //               value: 1,
                //               groupValue: SelectedRadio,
                //               title: const Text(
                //                 'Via Email:',
                //                 style: TextStyle(
                //                     fontFamily: 'Rubik',
                //                     fontSize: 12,
                //                     fontWeight: FontWeight.w400,
                //                     color: tab),
                //               ),
                //               subtitle: const Text(

                //                 'example@gmail.com',
                //                 style: TextStyle(
                //                     fontFamily: 'Rubik',
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w900,
                //                     color: black),
                //               ),
                //               onChanged: (val) {
                //                 setSelectedRadio(val!);
                //               },
                //               activeColor: red,
                //               selected: false,
                //             )),
                //       ),
                //       const SizedBox(
                //         height: 20,
                //       ),
                //       // GestureDetector(
                //       //   onTap: () {
                //       //     setState(() {
                //       //       selected = 'first';
                //       //     });
                //       //   },
                //       //   child:
                //       Container(
                //         height: 70,
                //         decoration: BoxDecoration(
                //           border: Border.all(width: 2, color: grey),
                //           // selected == 'first' ? Colors.blue : Colors.red),
                //           borderRadius: const BorderRadius.all(Radius.circular(14)),
                //         ),
                //         child: RadioListTile(
                //           contentPadding: EdgeInsets.zero,
                //           dense: true,
                //           visualDensity: const VisualDensity(
                //             horizontal: VisualDensity.minimumDensity,
                //           ),
                //           value: 2,
                //           groupValue: SelectedRadio,
                //           title: const Text(
                //             'Via Phone:',
                //             style: TextStyle(
                //                 fontFamily: 'Rubik',
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.w400,
                //                 color: tab),
                //           ),
                //           subtitle: const Text(
                //             '******9895',
                //             style: TextStyle(
                //                 fontFamily: 'Rubik',
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w900,
                //                 color: black),
                //           ),
                //           onChanged: (val) {
                //             setSelectedRadio(val!);
                //           },
                //           activeColor: red,
                //           selected: false,
                //         ),
                //       ),

                //       // )
                //       // GridView.builder(

                //       //     scrollDirection: Axis.horizontal,
                //       //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       //       crossAxisCount: 2,
                //       //       crossAxisSpacing: 3,
                //       //       mainAxisSpacing: 2,
                //       //       childAspectRatio: (16 / 8),
                //       //     ),
                //       //     itemCount: _wordName.length,
                //       //     itemBuilder: (context, index) {
                //       //       return GestureDetector(
                //       //           onTap: () {
                //       //             setState(() {
                //       //               if (selectedIndexes.contains(index)) {
                //       //                 selectedIndexes.remove(index);
                //       //               } else {
                //       //                 selectedIndexes.remove(index);
                //       //               }
                //       //               // showButton = true;
                //       //             });
                //       //           },
                //       //           child: Container(
                //       //               margin: EdgeInsets.all(10),
                //       //               decoration: BoxDecoration(
                //       //                 color: selectedIndexes == index
                //       //                     ? Color(0xffDEB988).withOpacity(0.2)
                //       //                     : Color(0xffF4F4F6).withOpacity(0.5),
                //       //                 borderRadius: BorderRadius.circular(5.0),
                //       //                 border: Border.all(
                //       //                     color: selectedIndexes == index
                //       //                         ? Color(0xffDEB988)
                //       //                         : Colors.transparent,
                //       //                     width: 0.5),
                //       //                 image: const DecorationImage(
                //       //                   image: AssetImage('assets/images/bg2.png'),
                //       //                   fit: BoxFit.cover,
                //       //                 ),
                //       //               ),
                //       //               child: Row(children: [
                //       //                 Flexible(
                //       //                   child: Center(
                //       //                     child: Text(
                //       //                       _wordName[index].toUpperCase(),
                //       //                       textAlign: TextAlign.center,
                //       //                       style: TextStyle(
                //       //                         color: selectedIndexes == index
                //       //                             ? Color(0xffDEB988)
                //       //                             : Colors.black,
                //       //                         fontWeight: selectedIndexes == index
                //       //                             ? FontWeight.bold
                //       //                             : FontWeight.normal,
                //       //                         fontFamily: "Poppins",
                //       //                       ),
                //       //                     ),
                //       //                   ),
                //       //                 ),
                //       //               ])));
                //       //     })
                //     ],
                //   ),
                // ),
              ],
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    backgroundColor: red,
                    minimumSize: const Size.fromHeight(44),
                  ),
                  onPressed: () {
                    forget_password();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OtpScreen(
                              forgetemail: email.text,
                              // checkotp: otp.text,
                              // forgetemail: '',
                            )));
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void forget_password() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      'email': email.text,
      // 'otp': otp.text,
    };
    var url = ForgotPassword;
    var urlparse = Uri.parse(url);

    var res = await http.post(urlparse, body: data);
    // var url = "http://192.168.29.242:8000/api/forget_password";
    var response = (json.decode(res.body));
    {
      if (jsonDecode(res.body) == 200) {
        setState(() {
          message = response['message'];
        });
      } else {
        // print('error');
        // setState(() {
        //   message = userDetail['message'];
        // });
        print(data);
        print(message);
        print(jsonDecode(res.body));
      }
    }
  }
  // void forget_password() async {
  //   Map data = {
  //     'email': email.text,
  //   };

  //   print(data);
  // var url = "http://192.168.29.242:8000/api/forget_password";
  //   print(data);
  //   var res = await http.post(Uri.parse(url), body: data);
  //   var userDetail = (json.decode(res.body));
  //   {
  //     if (jsonDecode(res.body) == "false") {
  //       print("error");
  //     } else {
  //       setState(() {
  //         message = userDetail['message'];
  //       });
  //       print(jsonDecode(res.body));

  //       print(message);
  //     }
  //   }
  // }
}
