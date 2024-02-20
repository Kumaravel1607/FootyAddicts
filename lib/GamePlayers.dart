import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:footyaddicts/api/api.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/models/player.dart';
import 'package:footyaddicts/services/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Players extends StatefulWidget {
  Players({
    Key? key,
  }) : super(key: key);

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchplayer();
    // player();
  }

  late List<Playerlist> users = [];

  fetchplayer() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    print("--------1");
    var stadium_id = session.getString('stadium_id');

    print("--------5");

    print(stadium_id);

    Services.player().then((results) {
      setState(() {
        users = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: GestureDetector(
                onTap: () {},
                child: SingleChildScrollView(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                'Light Tee',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                '6/7',
                                style: TextStyle(
                                    color: tab,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 30,
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/openslot.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Open Slot',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: liteblack),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: 110,
                                child: ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    // shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: users.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final user = users[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              child: ClipOval(
                                                child: user.image == null
                                                    ? Image.network(
                                                        user.image,
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.network(
                                                        user.profileImage,
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),

                                            // CircleAvatar(
                                            //   radius: 30,
                                            //   backgroundImage: user
                                            //               .profileImage ==
                                            //           null
                                            //       ?

                                            //       //  BoxDecoration(
                                            //       // image: img == true
                                            //       //     ? DecorationImage(image: FileImage(image_path))
                                            //       // :
                                            //       NetworkImage(
                                            //           user.profileImage,
                                            //         )
                                            //       : NetworkImage(user.image
                                            //           // 'assets/images/av.png'
                                            //           ),
                                            // ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              user.userName,
                                              // 'Joshep Vijay',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: black),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              'Joined 2 months ago',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: tab),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              )
                              // ListView.builder(
                              //     shrinkWrap: true,
                              //     scrollDirection: Axis.vertical,
                              //     itemCount: 2,
                              //     itemBuilder: (ctx, i) {
                              //       return Padding(
                              //         padding: EdgeInsets.all(5),
                              //         child: CircleAvatar(
                              //           backgroundColor: red,
                              //           radius: 100.0,
                              //           backgroundImage: AssetImage('assets/images/av.png'),
                              //         ),
                              //       );
                              //     })
                            ],
                          ),
                        ),
                        Container(
                          height: 750,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          color: Colors.grey.withOpacity(0.4),
                          width: 1,
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                'Dark Tee',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                '6/7',
                                style: TextStyle(
                                    color: tab,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 30,
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/openslot.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Open Slot',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: black),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: 110,
                                child: ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    // shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: users.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final user = users[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              child: ClipOval(
                                                child: user.image == null
                                                    ? Image.network(
                                                        user.image,
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.network(
                                                        user.profileImage,
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              user.userName,
                                              // 'Joshep Vijay',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: black),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              'Joined 2 months ago',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: tab),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
