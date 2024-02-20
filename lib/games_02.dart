import 'dart:io';

import 'package:flutter/material.dart';
import 'package:footyaddicts/GameDetails.dart';
// import 'package:footyaddicts/bookslot.dart';
import 'package:footyaddicts/Navigation.dart';
import 'package:footyaddicts/constant/color.dart';
// import 'package:footyaddicts/home.dart';
// import 'package:footyaddicts/home1.dart';
import 'package:footyaddicts/GamePlayers.dart';
import 'package:footyaddicts/games_01.dart';

class GameDetails extends StatefulWidget {
  final String std;
  GameDetails({Key? key, required this.std}) : super(key: key);

  @override
  State<GameDetails> createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
              MaterialPageRoute(builder: (context) => Games()),
            );
          },
          child: Icon(
            Icons.chevron_left,
            color: black,
          ),
        ),
        title: Text(
          'Talkatora Indoor Stadium,Delhi',
          style: TextStyle(
            color: black,
            fontFamily: 'IBMPlexSans',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  iconSize: 25,
                  color: black,
                  icon: Icon(
                    Icons.settings_outlined,
                  )),
              IconButton(
                onPressed: () {},
                iconSize: 25,
                color: black,
                icon: Icon(Icons.share_outlined),
                // icon: Image.asset(
                //   'assets/images/share.png',
                //   width: 19,
                //   height: 20,
                // )
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // SizedBox(height: 20.0),
              // Text('Tabs Inside Body',
              //     textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
              DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: TabBar(
                            indicatorColor: red,
                            labelColor: red,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(text: 'Details'),
                              Tab(text: 'Players'),
                              // Tab(text: 'Tab 3'),
                              // Tab(text: 'Tab 4'),
                            ],
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height *
                                1.25, //height of TabBarView
                            decoration: BoxDecoration(
                                color: black,
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: TabBarView(children: <Widget>[
                              Container(
                                child: Detail(
                                  stadium_id: widget.std,
                                ),
                                // child: Center(
                                //   child: Text('Display Tab 1',
                                //       style: TextStyle(
                                //           color: white,
                                //           fontSize: 22,
                                //           fontWeight: FontWeight.bold)),
                                // ),
                              ),
                              Container(
                                child: Players(),
                                // child: Center(
                                //   child: Text('Display Tab 2',
                                //       style: TextStyle(
                                //           fontSize: 22,
                                //           fontWeight: FontWeight.bold)),
                                // ),
                              ),
                              // Container(
                              //   child: Center(
                              //     child: Text('Display Tab 3',
                              //         style: TextStyle(
                              //             fontSize: 22,
                              //             fontWeight: FontWeight.bold)),
                              //   ),
                              // ),
                              // Container(
                              //   child: Center(
                              //     child: Text('Display Tab 4',
                              //         style: TextStyle(
                              //             fontSize: 22,
                              //             fontWeight: FontWeight.bold)),
                              //   ),
                              // ),
                            ]))
                      ])),
            ]),
      )),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     boxShadow: <BoxShadow>[
      //       BoxShadow(
      //         color: light,
      //       ),
      //     ],
      //   ),
      //   height: 70,
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         RichText(
      //           text: TextSpan(
      //             text: '₹220',
      //             style: TextStyle(
      //               fontSize: 24,
      //               fontWeight: FontWeight.w600,
      //               color: black,
      //             ),
      //             children: const <TextSpan>[
      //               TextSpan(
      //                   text: '/person \n incl. all taxes',
      //                   style: TextStyle(
      //                       color: tab,
      //                       fontWeight: FontWeight.w400,
      //                       fontSize: 12)),
      //             ],
      //           ),
      //         ),
      //         MaterialButton(
      //           height: 45,
      //           minWidth: 190,
      //           shape: RoundedRectangleBorder(
      //               borderRadius: new BorderRadius.circular(22)),
      //           onPressed: () {
      //             Navigator.of(context).pushReplacement(MaterialPageRoute(
      //                 builder: (BuildContext context) => BookSlot()));
      //           },
      //           child: Wrap(
      //             children: [
      //               Align(
      //                 alignment: Alignment.center,
      //                 child: Text('Book now',
      //                     style: TextStyle(
      //                       fontSize: 16,
      //                       fontWeight: FontWeight.w500,
      //                       color: white,
      //                     )),
      //               ),
      //               Icon(
      //                 Icons.chevron_right,
      //                 color: white,
      //                 size: 20,
      //               )
      //             ],
      //           ),
      //           color: red,
      //         ),

      //     ],
      //   ),
      //   ),
      // )
    );
  }
}
