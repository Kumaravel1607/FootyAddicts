import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:footyaddicts/AddGame.dart/add_game05.dart';
import 'package:footyaddicts/api/api.dart';
// import 'package:footyaddicts/bottomnavigation.dart';
// import 'package:footyaddicts/calendar.dart';
import 'package:footyaddicts/class.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/models/game_gender.dart';

import 'package:http/http.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/game_gender.dart';
import '../services/Services.dart';

class AddPage_02 extends StatefulWidget {
  AddPage_02({Key? key}) : super(key: key);

  @override
  State<AddPage_02> createState() => _AddPage_02State();
}

class _AddPage_02State extends State<AddPage_02> {
  List<String> _checked = [];
  // bool? value = false;
  final noti = [
    CheckBoxState(title: 'Private (Only invited people can join)'),
    CheckBoxState(title: 'Indoor')
  ];
  final maxLines = 10;
  String? Choose;
  // String? Type;

  // String dropdownvalue = 'Male';
  // String dropdownvalue1 = '5A side';
  // List ListItems = ['Male', 'Female', 'Others'];
  // List ListItems1 = ['5A side', '6A side', '7A side'];

  List Type = [];
  // List Gender = [];
  bool _isLoading = false;
  String? game;
  String? gender;

  Future<dynamic> gettype() async {
    Map data = {};
    SharedPreferences session = await SharedPreferences.getInstance();
    var Email = session.getString('email');
    var url = game_type;

    var urlparse = Uri.parse(url);

    Response res = await http.get(
      urlparse,
      // body: data,
    );
    if (res.statusCode == 200) {
      var resBody = (json.decode(res.body));

      print(resBody);
      setState(() {
        _isLoading = true;
        Type = resBody['game_type'];
      });

      return "Success";
    } else {
      _isLoading = false;
      print("error");
      print(res.body.toString());
    }
  }

  Future getgender() async {
    Map data = {};
    SharedPreferences session = await SharedPreferences.getInstance();
    var Email = session.getString('email');
    var url = game_gender;

    var urlparse = Uri.parse(url);

    Response res = await http.get(
      urlparse,
      // body: data,
    );
    if (res.statusCode == 200) {
      var resBody = (json.decode(res.body.toString()));

      print(resBody);
      setState(() {
        _isLoading = true;

        // Gender = resBody[''];
      });
      print(Gender);

      return "Success";
    } else {
      _isLoading = false;
      print("error");
      print(res.body.toString());
    }
  }

  late List<Gender> Gen = [];
  //  late List<Datum> users = [];

  fetchgender() async {
    Services.fetchgender().then((results) {
      setState(() {
        print(results[0].gender);

        Gen = results;
        print(gender);
        print(game);
      });
    });
  }

  final _text = TextEditingController();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
    gettype();
    // getgender();
    fetchgender();
  }

  late String title, Description;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: white,
          leadingWidth: 20,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Navigation()),
              // );
            },
            child: Icon(
              Icons.chevron_left,
              color: black,
            ),
          ),
          title: Text(
            'Add a Game',
            style: TextStyle(
              color: black,
              fontFamily: 'IBMPlexSans',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          'Add title, description and general rules for the game',
                          style: TextStyle(
                            color: black,
                            fontFamily: 'NunitoSans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Title',
                          style: TextStyle(
                            color: black,
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter title";
                            }
                            return null;
                          },
                          onSaved: (title) {
                            title = title!;
                          },
                          controller: _text,
                          decoration: InputDecoration(
                            // fillColor: light,
                            // filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(color: red, width: 2)),

                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: grey),
                                borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: grey),
                                borderRadius: BorderRadius.circular(24)),
                            contentPadding: const EdgeInsets.only(left: 20),
                            hintText: 'Add a game title',
                            hintStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal),
                            errorText:
                                _validate ? "Title Can't Be Empty" : null,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Description',
                          style: TextStyle(
                            color: black,
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 130,
                          child: TextFormField(
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter Description";
                              }
                              return null;
                            },
                            onSaved: (description) {
                              description = description!;
                            },
                            // validator: (val) {
                            //   return val.isEmpty
                            //       ? 'please provide a valid value'
                            //       : null;
                            // },

                            maxLines: maxLines,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              // fillColor: light,
                              // filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide(color: red, width: 2)),

                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(width: 2, color: grey),
                                  borderRadius: BorderRadius.circular(24)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: grey),
                                  borderRadius: BorderRadius.circular(24)),
                              contentPadding:
                                  const EdgeInsets.only(left: 24, top: 14),
                              hintText: 'Add game description (max. 50 words)',
                              hintStyle: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal),
                              // errorText: _validate
                              //     ? "Description Can't Be Empty"
                              //     : null,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Text(
                        //   'Game type',
                        //   style: TextStyle(
                        //     color: black,
                        //     fontFamily: 'Rubik',
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // TextField(
                        //   decoration: InputDecoration(
                        //       // fillColor: light,
                        //       // filled: true,
                        //       enabledBorder: OutlineInputBorder(
                        //           borderSide:
                        //               const BorderSide(width: 2, color: grey),
                        //           borderRadius: BorderRadius.circular(24)),
                        //       focusedBorder: OutlineInputBorder(
                        //           borderSide: const BorderSide(color: grey),
                        //           borderRadius: BorderRadius.circular(24)),
                        //       contentPadding: const EdgeInsets.only(left: 20),
                        //       hintText: 'Add a game type',
                        //       hintStyle: const TextStyle(
                        //           fontSize: 14,
                        //           fontFamily: 'NunitoSans',
                        //           fontWeight: FontWeight.w400,
                        //           fontStyle: FontStyle.normal),
                        //       suffixIcon:
                        //           Icon(Icons.keyboard_arrow_down, color: black)),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Text(
                          'Game type',
                          style: TextStyle(
                            color: black,
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Container(
                          height: 45,
                          child:
                              // Drop_down(
                              //     gametype, "partner_income", _gametype, 1),
                              DropdownButtonFormField<String>(
                            style: TextStyle(
                                color: black,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500),
                            value: game,
                            isExpanded: true,
                            onChanged: (newValue) {
                              setState(() {
                                game = newValue!;
                              });
                              gettype();
                            },
                            validator: (value) =>
                                value == null ? 'Select Game_Type' : null,
                            items: Type.map((List) {
                              return DropdownMenuItem<String>(
                                  child: Text(List['game_type'].toString()),
                                  value: List["id"].toString());
                            }).toList(),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 14, right: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(width: 2, color: grey),
                                  borderRadius: BorderRadius.circular(24)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(width: 2, color: grey),
                                  borderRadius: BorderRadius.circular(24)),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(24),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Gender',
                          style: TextStyle(
                            color: black,
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 45,
                          child:
                              //   Drop_down(
                              //       gametype, "partner_income", _gametype, 1),
                              // ),

                              DropdownButtonFormField<String>(
                            style: TextStyle(
                                color: black,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500),
                            value: gender,
                            isExpanded: true,
                            onChanged: (newValue) {
                              setState(() {
                                gender = newValue;
                              });
                              getgender();
                            },
                            validator: (value) =>
                                value == null ? 'Select Gender' : null,
                            items: Gen.map((List) {
                              return DropdownMenuItem<String>(
                                  child: Text(List.gender),
                                  value: List.id.toString());
                            }).toList(),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 14, right: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(width: 2, color: grey),
                                  borderRadius: BorderRadius.circular(24)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(width: 2, color: grey),
                                  borderRadius: BorderRadius.circular(24)),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(24),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // TextField(
                        //   decoration: InputDecoration(
                        //       // fillColor: light,
                        //       // filled: true,
                        //       enabledBorder: OutlineInputBorder(
                        //           borderSide:
                        //               const BorderSide(width: 2, color: grey),
                        //           borderRadius: BorderRadius.circular(24)),
                        //       focusedBorder: OutlineInputBorder(
                        //           borderSide: const BorderSide(color: grey),
                        //           borderRadius: BorderRadius.circular(24)),
                        //       contentPadding: const EdgeInsets.only(left: 20),
                        //       hintText: 'Add a Gender',
                        //       hintStyle: const TextStyle(
                        //         fontSize: 14,
                        //         fontFamily: 'NunitoSans',
                        //         fontWeight: FontWeight.w400,
                        //         fontStyle: FontStyle.normal,
                        //       ),
                        //       suffixIcon:
                        //           Icon(Icons.keyboard_arrow_down, color: black)),
                        // ),

                        //   ],
                        // )

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Checkbox(
                        //         activeColor: red,
                        //         value: _checkbox,
                        //         onChanged: (bool? val) {
                        //           setState(() {
                        //             _checkbox = val!;
                        //           });
                        //         }),
                        //     const Text(
                        //       'Private (Only invited people can join)',
                        //       style: TextStyle(
                        //           fontSize: 14,
                        //           fontFamily: 'Rubik',
                        //           fontWeight: FontWeight.w400,
                        //           fontStyle: FontStyle.normal),
                        //     )
                        //   ],
                        // ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Checkbox(
                        //         activeColor: red,
                        //         value: _checkbox,
                        //         onChanged: (val) {
                        //           setState(() {
                        //             _checkbox = val;
                        //           });
                        //         }),
                        //     const Text(
                        //       'Indoor',
                        //       style: TextStyle(
                        //           color: black,
                        //           fontSize: 14,
                        //           fontFamily: 'Rubik',
                        //           fontWeight: FontWeight.w400,
                        //           fontStyle: FontStyle.normal),
                        //     )
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 18,
                        // ),
                        // Text(
                        //   'Popular locations in your city',
                        //   style: TextStyle(
                        //       color: tab,
                        //       fontFamily: 'NunitoSans',
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w400),
                        // )
                        SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          height: 80,
                          child: ListView(
                            children: [
                              ...noti.map(buildSingleCheckBox).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
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
                          if (formkey.currentState!.validate()) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddPage3()));
                          } else {}

                          setState(() {
                            _text.text.isEmpty
                                ? _validate = true
                                : _validate = false;
                          });
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  buildSingleCheckBox(CheckBoxState checkbox) => CheckboxListTile(
      title: DefaultTextStyle(
        style: const TextStyle(
            color: black,
            fontFamily: 'Rubik',
            fontSize: 14,
            fontWeight: FontWeight.w400),
        child: Text(checkbox.title),
      ),
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
      visualDensity: VisualDensity(horizontal: -2, vertical: -3),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: red,
      value: checkbox.value,
      onChanged: ((value) => setState(
            () => checkbox.value = value!,
          )));

  // DropdownButtonFormField<String> Drop_down(
  //   List options,
  //   my_controller,
  //   selected_val,
  //   required,
  // ) {
  //   return DropdownButtonFormField<String>(
  //     // decoration: InputDecoration("Select"),
  //     value: selected_val == "" || selected_val == null
  //         ? null
  //         : selected_val.toString(),
  //     style: TextStyle(fontSize: 14),
  //     items: options.map((item) {
  //       return DropdownMenuItem<String>(
  //         value: item.categoryId.toString(),
  //         child: new Text(
  //           item.categoryName,
  //           style: TextStyle(
  //             color: black,
  //             fontSize: 15,
  //           ),
  //         ),
  //       );
  //     }).toList(),
  //     onChanged: (newValue) {
  //       setState(() {
  //         GameTypeID = newValue.toString();
  //         print(GameTypeID);
  //         Gametype();
  //       });
  //     },
  //     validator: (value) {
  //       if (required == 1) {
  //         print(value);
  //         if (value == "" || value == null) {
  //           return 'This field is requrired';
  //         }
  //         return null;
  //       } else {
  //         return null;
  //       }
  //     },
  //   );

}
