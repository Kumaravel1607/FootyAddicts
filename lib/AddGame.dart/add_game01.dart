import 'dart:async';

import 'package:flutter/material.dart';
import 'package:footyaddicts/Navigation.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/models/Stadium_list.dart';
import 'package:footyaddicts/services/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Location extends StatefulWidget {
  Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _LocationState extends State<Location> {
  late List<StadiumList> users = [];

  List<StadiumList> _search = [];
  final _debouncer = Debouncer();

  // List<Subject> ulist = [];
  // List<Subject> userLists = [];

  @override
  void initState() {
    super.initState();
    // users = [];
    fetchstadium();
  }

  void _Filter(String keyword) {
    List<Map<String, dynamic>> result = [];
    if (keyword.isEmpty) {
      result = users.cast<Map<String, dynamic>>();
    } else {}
  }

  fetchstadium() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    print("--------");
    var email = session.getString('email');

    print("--------");
    print(email);
    // print(date);
    Services.stadium().then((results) {
      setState(() {
        // if (date != null) {
        users = results;
        _search = users;

        //print(users[0].gameTittle);
        // } else {
        //   print('error');
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: white,
          leadingWidth: 20,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Navigation()),
              );
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
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (string) {
                      _debouncer.run(() {
                        setState(() {
                          _search = users
                              .where(
                                (u) => (u.stadiumName.toLowerCase().contains(
                                      string.toLowerCase(),
                                    )),
                              )
                              .toList();
                        });
                      });
                    },
                    // onChanged: (value) => _filter(value),
                    decoration: InputDecoration(
                        fillColor: light,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(24)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: grey),
                            borderRadius: BorderRadius.circular(24)),
                        contentPadding: const EdgeInsets.only(left: 20),
                        hintText: 'Search match location',
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Popular locations in your city',
                    style: TextStyle(
                      color: lgrey,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: _search.length,
                      itemBuilder: (context, index) {
                        final search = _search[index];
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  search.stadiumName,
                                  // 'Jawaharlal Nehru Stadium',
                                  style: TextStyle(
                                    color: black,
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    search.address,
                                    // 'New Delhi',
                                    style: TextStyle(
                                      color: lite,
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '1.5 KM',
                                    style: TextStyle(
                                      color: lite,
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                height: 10,
                                thickness: 0.5,
                                color: greylite,
                              )
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
