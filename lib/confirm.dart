import 'package:flutter/material.dart';
import 'package:footyaddicts/Navigation.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/home1.dart';
import 'package:footyaddicts/redirectpay.dart';

class Confirm extends StatefulWidget {
  Confirm({Key? key}) : super(key: key);

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
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
                MaterialPageRoute(builder: (context) => Redirect()),
              );
            },
            child: Icon(
              Icons.chevron_left,
              color: black,
            ),
          ),
          title: Text(
            'Thank you',
            style: TextStyle(
              color: black,
              fontFamily: 'IBMPlexSans',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          // actions: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: Image.asset(
          //         'assets/images/share.png',
          //         width: 19,
          //         height: 20,
          //       )),
          // ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 72),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 116,
                                width: 116,
                                // margin: EdgeInsets.all(100.0),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 116, 223, 119)
                                        .withOpacity(0.6),
                                    shape: BoxShape.circle),
                              ),
                              Positioned(
                                top: 28,
                                left: 28,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 5,
                                      color: Color.fromARGB(255, 75, 190, 79),
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.done_sharp,
                                      size: 30,
                                      color: Color.fromARGB(255, 75, 190, 79),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Your booking is Confirmed!',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'IBMPlexSans'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Game details have been sent to your registered email.',
                            style: TextStyle(
                                fontSize: 14,
                                color: lite,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'IBMPlexSans'),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 2,
                          color: red,
                        ),
                        borderRadius: BorderRadius.circular(22)),
                    backgroundColor: white,
                    minimumSize: const Size.fromHeight(44),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Navigation()));
                  },
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(
                      color: red,
                      fontSize: 16,
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // height: 116,
          // width: 116,
          // // margin: EdgeInsets.all(100.0),
          // decoration:
          //     BoxDecoration(color: Colors.lightGreen, shape: BoxShape.circle),
        )

        // Container(
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 72),
        //     child: Align(
        //       alignment: Alignment.topCenter,
        //       child: CircleAvatar(
        //         radius: 70,
        //         backgroundColor: Colors.lightGreen,
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
