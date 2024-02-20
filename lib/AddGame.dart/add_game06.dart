import 'package:flutter/material.dart';
import 'package:footyaddicts/Navigation.dart';
import 'package:footyaddicts/constant/color.dart';

class GameAdded extends StatefulWidget {
  GameAdded({Key? key}) : super(key: key);

  @override
  State<GameAdded> createState() => _GameAddedState();
}

class _GameAddedState extends State<GameAdded> {
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
            'Thank you',
            style: TextStyle(
              color: black,
              fontFamily: 'IBMPlexSans',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
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
                                    color: Color.fromARGB(255, 110, 223, 113)
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
                                      color: Color.fromARGB(255, 67, 201, 72),
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.done_sharp,
                                      size: 30,
                                      color: Color.fromARGB(255, 67, 201, 72),
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
                            'Game added successfully!',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'IBMPlexSans'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Share and invite your fellow players for a happy and successful game.',
                            style: TextStyle(
                                fontSize: 14,
                                color: lite,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'IBMPlexSans'),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160,
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Navigation()));
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
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22)),
                          backgroundColor: red,
                          minimumSize: const Size.fromHeight(44),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GameAdded()));
                        },
                        child: const Text(
                          'Share Game',
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
            ],
          ),

          // height: 116,
          // width: 116,
          // // margin: EdgeInsets.all(100.0),
          // decoration:
          //     BoxDecoration(color: Colors.lightGreen, shape: BoxShape.circle),
        ));
  }
}
