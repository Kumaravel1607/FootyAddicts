import 'dart:convert';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter/material.dart';
import 'package:footyaddicts/api/api.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  final String stadium_id;
  Detail({Key? key, required this.stadium_id}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  // var id = '';
  // late List<Datum> users = [];

  @override
  void initState() {
    super.initState();
    // users = [];
    details();
  }

  // late List<Details> users = [];
  // details() async {
  //   Services.details(id).then((results) {
  //     setState(() {
  //       print(results[0].gameTittle);

  //       users = results;
  //       print(users.length);

  //     });
  //   });
  // }

  String _stadium = "";
  String _rating = '';
  String _gametype = '';
  String _max = '';
  String _address = '';

  String _image = '';
  String _grass = '';
  String _description = '';
  String _cancel = '';
  String _country = '';
  String _state = '';
  String _time = '';
  String _date = '';
  String _coupon = '';

  details() async {
    var url = Game_detail;

    var urlparse = Uri.parse(url);
    Map data = {
      "stadium_id": widget.stadium_id,
    };
    print(data);
    http.Response res = await http.post(
      urlparse,
      body: data,
    );
    print(urlparse);
    print('---------1');

    if (res.statusCode == 200) {
      var resBody = (json.decode(res.body.toString()));
      print(resBody);
      setState(() {
        _stadium = (resBody['data']['stadium_name'].toString());
        _gametype = (resBody['data']['game_type'].toString());
        _grass = (resBody['data']['grass'].toString());
        _rating = (resBody['data']['rating'].toString());
        _max = (resBody['data']['max_player'].toString());
        _address = (resBody['data']['address'].toString());
        _state = (resBody['data']['state_name'].toString());
        _image = (resBody['data']['stadium_image'].toString());
        _description = (resBody['data']['description'].toString());
        _cancel = (resBody['data']['cancellation_policy'].toString());
        _date = (resBody['data']['date'].toString());
        _time = (resBody['data']['time'].toString());
        _country = (resBody['data']['country_name'].toString());
        _coupon = (resBody['data']['coupon_code'].toString());
      });

      final session = await SharedPreferences.getInstance();
      await session.setString('id', resBody['data']['id'].toString());
      await session.setString('stadium_id', resBody['data']['stadium_id']);
      await session.setString('stadium_name', resBody['data']['stadium_name']);

      await session.setString('game_type', resBody['data']['game_type']);
      await session.setString('grass', resBody['data']['grass']);
      await session.setString('price', resBody['data']['price']);
      await session.setString('time', resBody['data']['time']);
      await session.setString('date', resBody['data']['date']);
      await session.setString('platform_fee', resBody['data']['platform_fee']);
      await session.setString('state_name', resBody['data']['state_name']);
      await session.setString(
          'coupon_code', resBody['data']['coupon_code'].toString());
      await session.setString('total', resBody['data']['total'].toString());

      print(_stadium);
      print(_grass);
      // print(_coupon);
      print('--------3');

      return "Success";
    } else {
      print("error");
    }
  }
  // details() async {
  //   SharedPreferences session = await SharedPreferences.getInstance();
  //   print("--------");
  //   var email = session.getString('email');
  //   var id = session.getInt('stadium_id');

  //   print("--------1");
  //   print(email);
  //   print(id.toString());

  //   Services.det().then((results) {
  //     setState(() {
  //       // if (date != null) {
  //       users = results;

  //       //print(users[0].gameTittle);
  //       // } else {
  //       //   print('error');
  //       // }
  //     });
  //   });
  // }
  // String _stadium = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            // Padding(
            //     padding: const EdgeInsets.only(top: 25),
            //     child:
            GestureDetector(
                onTap: () {},
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .48,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Container(
                            //   height: 210,
                            //   decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //         image: NetworkImage(_image)),
                            //     color: Colors.blueGrey[100],

                            //     // borderRadius: BorderRadius.circular(5)
                            //   ),
                            // ),
                            Container(
                              height: 210,
                              width: MediaQuery.of(context).size.width,
                              // child: Image(image: NetworkImage(_image)),
                              // child:
                              //  Image.network(
                              //   _image,
                              //   fit: BoxFit.cover,
                              //   loadingBuilder:
                              //       (ctx, child, loadingProgress) {
                              //     if (loadingProgress == null) {
                              //       return child;
                              //     } else {
                              //       return Center(
                              //         child: CircularProgressIndicator(
                              //           valueColor:
                              //               AlwaysStoppedAnimation<Color>(
                              //                   Colors.green),
                              //         ),
                              //       );
                              //     }
                              //   },
                              // )
                              decoration: BoxDecoration(
                                // image: img == true
                                //     ? DecorationImage(image: FileImage(image_path))
                                // :
                                image: DecorationImage(
                                    image: NetworkImage(
                                  _image,
                                )),
                              ),
                            ),
                            // child: Image.network(
                            //   _image,
                            //   // child: _image != null
                            //   //     ? Image.network(
                            //   //         _image,
                            //   //         fit: BoxFit.fill,
                            //   //       )
                            //   //     : Image.network(_image),
                            //   //  Image.asset(
                            //   //   'assets/images/stadium2.webp',
                            //   //   fit: BoxFit.fill,
                            //   // ),
                            // )),
                            Positioned(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 170, left: 16, right: 16),
                                child: Container(
                                  height: 210,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: grey,
                                      style: BorderStyle.solid,
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${_stadium}' ',' '${_state}',
                                                // 'Talkatora Indoor Stadium, \n New Delhi',
                                                style: TextStyle(
                                                  color: black,
                                                  fontFamily: 'NunitoSans',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Container(
                                                height: 21,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: green,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    _rating,
                                                    // '4.5',
                                                    style: TextStyle(
                                                        color: white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${_gametype}' ',' '${_grass}',
                                                // '5A side, Natural Grass',
                                                style: TextStyle(
                                                  color: dash,
                                                  fontFamily: 'NunitoSans',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'Hurry up 2 Slots left',
                                                style: TextStyle(
                                                  color: red,
                                                  fontFamily: 'NunitoSans',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                          ),
                                          child: Dash(
                                              direction: Axis.horizontal,
                                              dashLength: 5,
                                              length: 310,
                                              dashColor: grey),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  color: tab,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  _date,
                                                  // 'Monday, 23 Jan.',
                                                  style: TextStyle(
                                                    color: dash,
                                                    fontFamily: 'NunitoSans',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 65,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: tab,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  _time,
                                                  // '10 AM - 12 PM',
                                                  style: TextStyle(
                                                    color: dash,
                                                    fontFamily: 'NunitoSans',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.person_outline,
                                                  color: tab,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Open for all',
                                                  style: TextStyle(
                                                    color: dash,
                                                    fontFamily: 'NunitoSans',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 70,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .supervisor_account_outlined,
                                                  color: tab,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  _max,
                                                  // '14 Players',
                                                  style: TextStyle(
                                                    color: dash,
                                                    fontFamily: 'NunitoSans',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: tab,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '${_stadium}'
                                              '${_address}'
                                              '\n'
                                              '${_state}',
                                              // "Talkatora Ln, Talkatora Garden, President's Estate,\n New Delhi, Delhi 110004",
                                              style: TextStyle(
                                                color: dash,
                                                fontFamily: 'NunitoSans',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Description',
                          style: TextStyle(
                              color: black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'IBMPlexSans'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: Text(
                          _description,

                          //'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nEtiam venenatis semper nisl, quis volutpat quam efficitur\nsed.',
                          style: TextStyle(
                              color: lite,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'NunitoSans'),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: Text(
                          'Nullam fringilla lacus turpis, a pretium magna sodales et.\nUt eget egestas arcu, eu eleifend eros.\nDuis commodo sodales enim, sit amet lacinia erat facilisis nec.\nMauris vestibulum ipsum vitae pharetra sollicitudin.\nNunc accumsan erat ac erat bibendum, vel posuere sem facilisis.',
                          style: TextStyle(
                              color: lite,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'NunitoSans'),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. \nEtiam venenatis semper nisl, quis volutpat quam efficitur \nsed.',
                          style: TextStyle(
                              color: lite,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'NunitoSans'),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. \nEtiam venenatis semper nisl, quis volutpat quam efficitur \nsed.',
                          style: TextStyle(
                              color: lite,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'NunitoSans'),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Cancellation Policy',
                          style: TextStyle(
                              color: black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'IBMPlexSans'),
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: Text(
                          _cancel,
                          //'Lorem ipsum dolor sit amet, consectetur adipiscing elit. \nEtiam venenatis semper nisl, quis volutpat quam efficitur \nsed.',
                          style: TextStyle(
                              color: lite,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'NunitoSans'),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Column(
                  //         children: [
                  //           Text(
                  //             'Light Tea',
                  //             style: TextStyle(
                  //                 fontSize: 12, fontWeight: FontWeight.w700),
                  //           ),
                  //           SizedBox(
                  //             height: 2,
                  //           ),
                  //           Text(
                  //             '6/7',
                  //             style: TextStyle(
                  //                 color: tab,
                  //                 fontSize: 12,
                  //                 fontWeight: FontWeight.w600),
                  //           ),
                  //           SizedBox(
                  //             height: 20,
                  //           ),
                  //           CircleAvatar(
                  //             radius: 30,
                  //             backgroundImage: AssetImage('assets/images/av.png'),
                  //           ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             'Open Slot',
                  //             style: TextStyle(
                  //                 fontSize: 12,
                  //                 fontWeight: FontWeight.w500,
                  //                 color: liteblack),
                  //           ),
                  //           SizedBox(
                  //             height: 20,
                  //           ),
                  //           Container(
                  //             height: 620,
                  //             width: 110,
                  //             child: ListView.builder(
                  //                 // physics: const ClampingScrollPhysics(),
                  //                 // shrinkWrap: true,
                  //                 scrollDirection: Axis.vertical,
                  //                 itemCount: 6,
                  //                 itemBuilder: (BuildContext context, int index) {
                  //                   return Padding(
                  //                     padding: const EdgeInsets.all(8.0),
                  //                     child: Column(
                  //                       children: [
                  //                         CircleAvatar(
                  //                           radius: 30,
                  //                           backgroundImage: AssetImage(
                  //                             'assets/images/av.png',
                  //                           ),
                  //                         ),
                  //                         SizedBox(
                  //                           height: 5,
                  //                         ),
                  //                         Text(
                  //                           'Joshep Vijay',
                  //                           style: TextStyle(
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w700,
                  //                               color: black),
                  //                         ),
                  //                         SizedBox(
                  //                           height: 2,
                  //                         ),
                  //                         Text(
                  //                           'Joined 2 months ago',
                  //                           style: TextStyle(
                  //                               fontSize: 10,
                  //                               fontWeight: FontWeight.w400,
                  //                               color: tab),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   );
                  //                 }),
                  //           )
                  //           // ListView.builder(
                  //           //     shrinkWrap: true,
                  //           //     scrollDirection: Axis.vertical,
                  //           //     itemCount: 2,
                  //           //     itemBuilder: (ctx, i) {
                  //           //       return Padding(
                  //           //         padding: EdgeInsets.all(5),
                  //           //         child: CircleAvatar(
                  //           //           backgroundColor: red,
                  //           //           radius: 100.0,
                  //           //           backgroundImage: AssetImage('assets/images/av.png'),
                  //           //         ),
                  //           //       );
                  //           //     })
                  //         ],
                  //       ),
                  //       Container(
                  //         height: 750,
                  //         margin: const EdgeInsets.symmetric(vertical: 10),
                  //         color: Colors.grey.withOpacity(0.4),
                  //         width: 1,
                  //       ),
                  //       Column(
                  //         children: [
                  //           Text(
                  //             'Dark Tee',
                  //             style: TextStyle(
                  //                 fontSize: 12, fontWeight: FontWeight.w700),
                  //           ),
                  //           SizedBox(
                  //             height: 2,
                  //           ),
                  //           Text(
                  //             '6/7',
                  //             style: TextStyle(
                  //                 color: tab,
                  //                 fontSize: 12,
                  //                 fontWeight: FontWeight.w600),
                  //           ),
                  //           SizedBox(
                  //             height: 20,
                  //           ),
                  //           CircleAvatar(
                  //             radius: 30,
                  //             backgroundImage: AssetImage('assets/images/av.png'),
                  //           ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             'Open Slot',
                  //             style: TextStyle(
                  //                 fontSize: 12,
                  //                 fontWeight: FontWeight.w500,
                  //                 color: black),
                  //           ),
                  //           SizedBox(
                  //             height: 20,
                  //           ),
                  //           Container(
                  //             height: 620,
                  //             width: 110,
                  //             child: ListView.builder(
                  //                 // physics: const ClampingScrollPhysics(),
                  //                 // shrinkWrap: true,
                  //                 scrollDirection: Axis.vertical,
                  //                 itemCount: 6,
                  //                 itemBuilder: (BuildContext context, int index) {
                  //                   return Padding(
                  //                     padding: const EdgeInsets.all(8.0),
                  //                     child: Column(
                  //                       children: [
                  //                         CircleAvatar(
                  //                           radius: 30,
                  //                           backgroundImage: AssetImage(
                  //                             'assets/images/av.png',
                  //                           ),
                  //                         ),
                  //                         SizedBox(
                  //                           height: 5,
                  //                         ),
                  //                         Text(
                  //                           'Joshep Vijay',
                  //                           style: TextStyle(
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w700,
                  //                               color: black),
                  //                         ),
                  //                         SizedBox(
                  //                           height: 2,
                  //                         ),
                  //                         Text(
                  //                           'Joined 2 months ago',
                  //                           style: TextStyle(
                  //                               fontSize: 10,
                  //                               fontWeight: FontWeight.w400,
                  //                               color: tab),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   );
                  //                 }),
                  //           )
                  //         ],
                  //       ),
                  //     ],)
                  //   ),
                  // ),
                  // )
                )));
  }
}
