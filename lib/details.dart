import 'package:flutter/material.dart';
import 'package:footyaddicts/constant/color.dart';

class Details extends StatefulWidget {
  Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                          radius: 30,
                          backgroundImage: AssetImage('assets/images/av.png'),
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
                          height: 620,
                          width: 110,
                          child: ListView.builder(
                              // physics: const ClampingScrollPhysics(),
                              // shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: 6,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                          'assets/images/av.png',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Joshep Vijay',
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
                    Container(
                      height: 750,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.grey.withOpacity(0.4),
                      width: 1,
                    ),
                    Column(
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
                          radius: 30,
                          backgroundImage: AssetImage('assets/images/av.png'),
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
                          height: 620,
                          width: 110,
                          child: ListView.builder(
                              // physics: const ClampingScrollPhysics(),
                              // shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: 6,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                          'assets/images/av.png',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Joshep Vijay',
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
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}

          // ListView.builder(
          //     // physics: const ClampingScrollPhysics(),
          //     shrinkWrap: true,
          //     scrollDirection: Axis.vertical,
          //     itemCount: 2,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Padding(
          //         padding: const EdgeInsets.all(2),
          //         child: GestureDetector(
          //           onTap: () {
          //             // Navigator.of(context).pushReplacement(
          //             //     MaterialPageRoute(
          //             //         builder: (BuildContext context) =>
          //             //             Details()));
          //           },
          //           child: CircleAvatar(
          //             radius: 20,
          //             backgroundImage: AssetImage('assets/images/av.png'),
          //           ),
          //         ),
          //       );
          //     }),
//           ),
//     );
//   }
// }
