import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:footyaddicts/api/api.dart';
import 'package:footyaddicts/confirm.dart';
import 'package:footyaddicts/home2.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:footyaddicts/redirectpay.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'constant/color.dart';

class BookSlot extends StatefulWidget {
  BookSlot({Key? key}) : super(key: key);

  @override
  State<BookSlot> createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
  var tcVisibility = false;
  TextEditingController coupon = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // users = [];
    bookslot();
  }

  String _stadium = "";
  String _grass = '';
  String _gametype = '';
  String _price = '';
  String _state = '';
  String _platform = '';
  String _date = '';
  String _time = '';
  String _total = '';
  bookslot() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var stadium_id = session.getString('stadium_id');
    var stadium_name = session.getString('stadium_name');
    var user_id = session.getInt('user_id');
    var grass = session.getString('grass');
    var game_type = session.getString('game_type');
    var price = session.getString('price');
    var platform_fee = session.getString('platform_fee');
    var date = session.getString('date');
    var time = session.getString('time');
    var state = session.getString('state_name');
    var coupon_code = session.getString('coupon_code');
    var total = session.getString('total');

    var url = book_slot;

    var urlparse = Uri.parse(url);
    Map data = {
      'grass': grass.toString(),
      'game_type': game_type.toString(),
      'price': price.toString(),
      'user_id': user_id.toString(),
      "stadium_id": stadium_id.toString(),
      "coupon_code": coupon_code.toString(),
      // "stadium_name": stadium_name.toString(),
      "platform_fee": platform_fee.toString(),
    };
    print(data);
    http.Response res = await http.post(
      urlparse,
      body: data,
    );
    print(urlparse);
    print('---------1');
    var resBody = (json.decode(res.body.toString()));
    // _stadium = (resBody['stadium_name'].toString());
    // print(_stadium);
    print(resBody);
    if (res.statusCode == 200) {
      var resBody = (json.decode(res.body.toString()));
      // _stadium = (resBody['data']['stadium_name'].toString());
      setState(() {
        _date = date.toString();
        _platform = platform_fee.toString();
        _time = time.toString();
        _state = state.toString();
        _price = price.toString();
        _grass = grass.toString();
        _stadium = stadium_name.toString();
        _gametype = game_type.toString();
        _total = total.toString();
      });

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Confirm()));

      // await prefs.setString('email', resBody['data']['']);

      // print(_stadium);
      // print(_grass);
      print('-----3-----');
      print(_gametype);
      print(_stadium);
      print(_state);
      print(_platform);
      print(_price);
      print(_grass);
      print(_date);
      print(_time);
      print(_total);
      print('--------3');

      //  Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => LogScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(resBody['message'].toString()),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

  String _percent = "";
  String _discount = '';
  String _newprice = '';
  promo() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var platform_fee = session.getString('platform_fee');
    var price = session.getString('price');
    var url = coupon_Code;
    var data = {
      'amount': price.toString(),
      "coupon_code": coupon.text,
      "platform_fee": _platform.toString()
    };

    var body = json.encode(data);
    var urlparse = Uri.parse(url);

    Response response = await http.post(
      urlparse,
      body: data,
    );
    var response_data = json.decode(response.body.toString());
    print(response_data);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      setState(() {
        _percent = (response_data['data']['percent'].toString());
        _discount = (response_data['data']['discount_value'].toString());
        _newprice = (response_data['data']['new_price'].toString());

        tcVisibility = true;
      });
      print(_percent);
      print(_discount);
      print(_newprice);
      // print('Sucessfull');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response_data['message'].toString()),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

  var focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: white,
        leadingWidth: 20,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
            );
          },
          child: Icon(
            Icons.chevron_left,
            color: black,
          ),
        ),
        title: Text(
          'Book a Slot',
          style: TextStyle(
            color: black,
            fontFamily: 'IBMPlexSans',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Slot Details',
                  style: TextStyle(
                    color: black,
                    fontFamily: 'IBMPlexSans',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 115,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: grey,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          '${_stadium}' ',' '${_state}',
                          // 'Talkatora Indoor Stadium, New Delhi',
                          style: TextStyle(
                            color: black,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '${_gametype}' ',' '${_grass}',
                          // '5A side, Natural Grass',
                          style: TextStyle(
                            color: dash,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Dash(
                            direction: Axis.horizontal,
                            dashLength: 5,
                            length: 325,
                            dashColor: grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                            width: 45,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price Summary',
                    style: TextStyle(
                      color: black,
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                height: 230,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Add promo code',
                                              style: TextStyle(
                                                color: black,
                                                fontFamily: 'IBMPlexSans',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(Icons.close))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 16,
                                        ),
                                        child: TextFormField(
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "invalid code";
                                            }

                                            return null;
                                          },
                                          onSaved: (value) {},
                                          controller: coupon,
                                          keyboardType: TextInputType.text,
                                          autocorrect: true,
                                          focusNode: focusNode,
                                          decoration: InputDecoration(
                                              fillColor: light,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 3,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24)),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 20),
                                              hintText: 'Search',
                                              hintStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'NunitoSans',
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                  width: 2,
                                                  color: red,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(22)),
                                            backgroundColor: white,
                                            minimumSize:
                                                const Size.fromHeight(44),
                                          ),
                                          onPressed: () {
                                            if (formkey.currentState!
                                                .validate()) {}
                                            promo();
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //         builder: (context) => Redirect()));
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //         builder: (context) => Confirm()));
                                          },
                                          child: const Text(
                                            'Apply',
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
                                ),
                              ),
                            );
                          });
                    },
                    child: Text(
                      '+ Add promo code',
                      style: TextStyle(
                        color: red,
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Slot (1 person)',
                    style: TextStyle(
                      color: black,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    _price,
                    // '200',
                    style: TextStyle(
                      color: black,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Platform fee',
                    style: TextStyle(
                      color: black,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    _platform,
                    // '20',
                    style: TextStyle(
                      color: black,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Visibility(
                visible: tcVisibility,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$_percent' ' OFF',
                          style: TextStyle(
                            color: black,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'REMOVE',
                          style: TextStyle(
                            color: red,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    Text(
                      '- ' '$_discount',
                      // '20',
                      style: TextStyle(
                        color: black,
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: grey,
                height: 25,
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: black,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  tcVisibility == true
                      ? Text(
                          _newprice,
                          style: TextStyle(
                            color: black,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        )
                      : Text(
                          _total,
                          // '290',
                          style: TextStyle(
                            color: black,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  // side: const BorderSide(
                  //   width: 2,
                  //   color: red,
                  // ),
                  borderRadius: BorderRadius.circular(22)),
              backgroundColor: red,
              minimumSize: const Size.fromHeight(40),
            ),

            //  MaterialButton(
            //   height: 50,
            //   minWidth: 190,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: new BorderRadius.circular(22)),
            onPressed: () {
              // bookslot();
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     builder: (BuildContext context) => Confirm()));
            },
            child: Wrap(
              children: [
                Text('Complete Payment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: white,
                    )),
                Icon(
                  Icons.chevron_right,
                  color: white,
                  size: 20,
                )
              ],
            ),
            // color: red,
          ),
        ),
      ),
    );
  }
}
