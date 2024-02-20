import 'package:flutter/material.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/home2.dart';
import 'package:footyaddicts/games_02.dart';
import 'package:footyaddicts/models/home_page.dart';
import 'package:footyaddicts/notification.dart';
import 'package:footyaddicts/services/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';

class Games extends StatefulWidget {
  Games({Key? key}) : super(key: key);

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();

  bool _validate = false;
  var date = "";
  @override
  void dispose() {
    super.dispose();
  }

  late List<Datum> users = [];

  @override
  void initState() {
    super.initState();
    // users = [];
    fetchHome();
  }

  fetchHome() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    print("--------");
    var email = session.getString('email');

    print("--------");
    print(email);
    print(date);
    Services.fetchHome(date).then((results) {
      setState(() {
        users = results;

        //print(users[0].gameTittle);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          centerTitle: false,
          leadingWidth: 0,
          elevation: 1,
          title: const Text(
            'My Games',
            style: TextStyle(
                color: black,
                fontSize: 16,
                fontFamily: 'IBMPlexSans',
                fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => NotificationPage())));
                },
                icon: Image.asset(
                  'assets/images/Notification.png',
                  width: 18,
                  height: 20,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: TextField(
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
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal)),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  // SizedBox(
                  //   height: 70,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       physics: const ClampingScrollPhysics(),
                  //       shrinkWrap: false,
                  //       itemCount: 7,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         return Padding(
                  //           padding: const EdgeInsets.only(
                  //               top: 8, right: 8, bottom: 8),
                  //           child: Container(
                  //             width: 50,
                  //             height: 50,
                  //             decoration: BoxDecoration(
                  //               border: Border.all(width: 2, color: light),
                  //               borderRadius:
                  //                   const BorderRadius.all(Radius.circular(8)),
                  //             ),
                  //             child: Column(
                  //               children: <Widget>[
                  //                 Padding(
                  //                   padding: const EdgeInsets.only(
                  //                       left: 9, top: 5, right: 5),
                  //                   child: Column(
                  //                     children: const [
                  //                       Text(
                  //                         'Mon',
                  //                         style: TextStyle(
                  //                             color: grey,
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.w400,
                  //                             fontFamily: 'NunitoSans'),
                  //                       ),
                  //                       Text(
                  //                         '24',
                  //                         style: TextStyle(
                  //                             color: black,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.w600,
                  //                             fontFamily: 'NunitoSans'),
                  //                       )
                  //                     ],
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         );
                  //       }),
                  // ),
                  SizedBox(
                    height: 80,
                    child: DatePicker(
                      DateTime.now(),
                      width: 50,
                      height: 60,
                      controller: _controller,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: red,
                      selectedTextColor: white,
                      onDateChange: (date_s) {
                        // New date selected
                        print(date_s);
                        print('------');
                        setState(() {
                          final f = new DateFormat('yyyy-MM-dd');

                          date = f.format(date_s);
                          print(date);
                          print('......');
                          fetchHome();
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  // ListView.builder(itemBuilder: (context, index) {
                  //   return Card(
                  //     child: Text('data'),
                  //   );
                  // })
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (BuildContext context) => GameDetails(
                      //     ,
                      //     )));
                    },
                    child: users.length == 0
                        ? Text(
                            "No  Data Found",
                            style: TextStyle(color: black),
                          )
                        : ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: users.length,
                            itemBuilder: (BuildContext context, int index) {
                              final user = users[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Details(
                                                  price: user.price,
                                                  std: user.stadiumId,
                                                )));
                                  },
                                  child: Container(
                                    height: 130,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: bg, width: 2),

                                      // border: Border.all(
                                      //     // Set border color
                                      //     width: 3.0), // Set border width
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomLeft: Radius.circular(8)),
                                          child: Image.network(
                                            user.stadiumImage,
                                            //Image.asset(

                                            // 'assets/images/stadium2.webp',
                                            width: 116,
                                            height: 141,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              '${user.time}'
                                              ' • '
                                              '₹ '
                                              '${user.price}',
                                              style: TextStyle(
                                                  color: tab,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'NunitoSans'),
                                            ),
                                            Text(
                                              '${user.stadiumName}'
                                              ','
                                              ' \n'
                                              '${user.stateName}',
                                              // 'Talkatora Indoor Stadium,\n New Delhi',
                                              style: TextStyle(
                                                  color: black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'NunitoSans'),
                                            ),
                                            Text(
                                              '${user.gameType}'
                                              ' • '
                                              '${user.status}'
                                              ' • '
                                              '${user.maxPlayer}'
                                              ' \n',
                                              // '5A Side : Open : Max 10 Players \n by ranjeet1137',
                                              style: TextStyle(
                                                  color: tab,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
