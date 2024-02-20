import 'package:flutter/material.dart';
import 'package:footyaddicts/Welcome.dart';
import 'package:footyaddicts/class.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/controller/homecontroller.dart';
import 'package:footyaddicts/drawer.dart';
import 'package:footyaddicts/home2.dart';
import 'package:footyaddicts/models/home_page.dart';
import 'package:footyaddicts/notification.dart';
import 'package:footyaddicts/services/Services.dart';
import 'package:footyaddicts/services/remote_services.dart';
import 'package:footyaddicts/test.dart';
import 'package:footyaddicts/Notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();
  // final CacheManager cacheManager = CacheManager(Config('image_key',
  //     maxNrOfCacheObjects: 10, stalePeriod: Duration(days: 5)));
  double _value = 0.0;
  String? _status;
  List<String> _checked = [];
  // bool? value = false;
  final noti = [
    CheckBoxState(title: 'Outdoor'),
    CheckBoxState(title: 'Indoor')
  ];
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

  // final items = List<DateTime>.generate(15, (i) {
  //   final DateTime now = DateTime.now();

  //   // final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //   // final String formatted = formatter.format(now);
  //   print(DateFormat.d().format(DateTime.now()));

  //   DateTime date = DateTime.utc(
  //     DateTime.now().year,
  //     DateTime.now().month,
  //     DateTime.now().day,
  //   );

  //   date.add(Duration(days: i));

  //   return date;
  // });
  // Future<void> fetchHome() async {
  //   final response = await Services.fetchHome();
  //   setState(() {
  //     users = response;
  //   });
  // }

  // Future<void> fetchHome() async {
  //   final response = await Services.fetchHome();
  //   setState(() {
  //     users = response.cast<Datum>();
  //   });
  // }

  // final List myData = List.generate(100, (index) => 'Item $index');
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  TextEditingController text = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // width:
    // double.infinity;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _globalKey,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Image.asset(
              'assets/images/FootyConnect1.png',
              width: 31,
              height: 36,
            ),
          ),
          titleSpacing: 2,
          title: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Image.asset(
              'assets/images/FootyConnect3.png',
              height: 11,
              width: 126,
            ),
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
        endDrawer: Drawer(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Filter',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: black,
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal)),
                            IconButton(
                              icon: Icon(Icons.cancel, color: red),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                        Card(
                          child: new ListTile(
                            leading: new Icon(Icons.search),
                            title: new TextField(
                              controller: text,
                              decoration: new InputDecoration(
                                  hintText: 'Search', border: InputBorder.none),
                              // onChanged: onSearchTextChanged,
                            ),
                            trailing: new IconButton(
                              icon: new Icon(
                                Icons.cancel_outlined,
                              ),
                              onPressed: () {
                                // controller.clear();
                                // onSearchTextChanged('');
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Category',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: black,
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal)),
                            TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Text('View all',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: black,
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal)),
                                    Icon(Icons.chevron_right, color: black)
                                  ],
                                ))
                          ],
                        ),
                        Divider(
                          thickness: 0.5,
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Game Type',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: black,
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal)),
                            TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Text('View all',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: black,
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal)),
                                    Icon(Icons.chevron_right, color: black)
                                  ],
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Obx(() {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: false,
                                itemCount: users.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final user = users[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      width: 90,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: red,
                                        border:
                                            Border.all(width: 1, color: light),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "5A side",
                                          // user.gameType,
                                          style: TextStyle(
                                              color: white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'NunitoSans'),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                        ),
                        Divider(
                          thickness: 0.5,
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Stadium',
                            style: TextStyle(
                                fontSize: 14,
                                color: black,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal)),
                        SizedBox(
                          height: 80,
                          child: ListView(
                            children: [
                              ...noti.map(buildSingleCheckBox).toList(),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Booking Price',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: black,
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal)),
                            Text('$_status',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: black,
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal))
                          ],
                        ),

                        Slider(
                          thumbColor: red,
                          activeColor: red,
                          inactiveColor: grey,
                          min: 0.0,
                          max: 500.0,
                          value: _value,
                          // divisions: 5,

                          onChanged: (value) {
                            setState(() {
                              _value = value;
                              _status = '${_value.round()}';

                              // _statusColor = Colors.green;
                            });
                          },
                          // onChangeStart: (value) {
                          //   setState(() {
                          //     _status = 'start';
                          //     // _statusColor = Colors.lightGreen;
                          //   });
                          // },
                          // onChangeEnd: (value) {
                          //   setState(() {
                          //     _status = 'end';
                          //     // _statusColor = Colors.red;
                          //   });
                          // },
                        ),
                        // Text(
                        //   'Price: $_status',
                        //   style: TextStyle(color: red),
                        // ),
                        Divider(
                          thickness: 0.5,
                          height: 10,
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 50,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 30, left: 15, right: 15),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22)),
                          backgroundColor: red,
                          minimumSize: const Size.fromHeight(44),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          // if (formkey.currentState!.validate()) {
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => Navigation()));
                          // } else {}
                        },
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        // drawer: Drawer(),
        body: CustomScrollView(slivers: [
          // SliverAppBar(
          //   backgroundColor: white,
          //   pinned: true,
          //   leading: Padding(
          //     padding: const EdgeInsets.only(left: 16),
          //     child: Image.asset(
          //       'assets/images/FootyConnect1.png',
          //       width: 31,
          //       height: 36,
          //     ),
          //   ),
          //   titleSpacing: 2,
          //   title: Padding(
          //     padding: const EdgeInsets.only(left: 6),
          //     child: Image.asset(
          //       'assets/images/FootyConnect3.png',
          //       height: 11,
          //       width: 126,
          //     ),
          //   ),
          //   actions: [
          //     IconButton(
          //         onPressed: () {},
          //         icon: Image.asset(
          //           'assets/images/Notification.png',
          //           width: 18,
          //           height: 20,
          //         ))
          //   ],
          // ),
          SliverToBoxAdapter(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 14, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 274,
                          height: 44,
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
                        Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: light,
                            border:
                                Border.all(width: 2, color: Colors.transparent),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: IconButton(
                              onPressed: () {
                                _globalKey.currentState?.openEndDrawer();
                                // Scaffold.of(context).openDrawer();
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => Filter()));
                              },
                              icon: Image.asset(
                                'assets/images/setting.png',
                                width: 25,
                                height: 20,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Featured',
                          style: TextStyle(
                              color: black,
                              fontFamily: 'IBMPlexSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TestScreen()));
                          },
                          child: Text(
                            "See all",
                            style: TextStyle(
                                color: red,
                                fontFamily: 'NunitoSans',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            height: 130,
                            width: 370,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                black,
                                Colors.transparent,
                              ]),
                              image: DecorationImage(
                                  image: const AssetImage(
                                    'assets/images/stadium1.jpeg',
                                  ),
                                  colorFilter: ColorFilter.mode(
                                      black.withOpacity(0.3), BlendMode.darken),
                                  fit: BoxFit.cover),
                              border: Border.all(
                                  width: 2, color: Colors.transparent),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            // child: Image.asset(name),
                          ),
                        ),
                        const Positioned(
                          top: 25,
                          left: 16,
                          child: Text(
                            'We going ',
                            style: TextStyle(
                                color: white,
                                fontFamily: 'IBMPlexSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                        const Positioned(
                          // top: 35,
                          left: 16,
                          bottom: 52,
                          child: Text(
                            'International!',
                            style: TextStyle(
                                color: white,
                                fontFamily: 'IBMPlexSans',
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                        const Positioned(
                          bottom: 27,
                          left: 16,
                          child: Text(
                            'Kick to know more :)',
                            style: TextStyle(
                                color: white,
                                fontFamily: 'IBMPlexSans',
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // SingleChildScrollView(
                    //   child: Container(
                    //       child: ListView.builder(
                    //           shrinkWrap: true,
                    //           scrollDirection: Axis.horizontal,
                    //           // itemCount: ,
                    //           itemBuilder: (context, index) {
                    //             return Card(
                    //               child: Text('data'),
                    //             );
                    //           })),
                    // )

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

                    // SizedBox(
                    //   height: 70,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       physics: const ClampingScrollPhysics(),
                    //       shrinkWrap: false,
                    //       itemCount: items.length,
                    //       itemBuilder: (BuildContext context, int index) {
                    //         return Padding(
                    //           padding: const EdgeInsets.only(
                    //               right: 8, bottom: 8, top: 8.0),
                    //           child: GestureDetector(
                    //             onTap: () {
                    //               setState(() {
                    //                 print("aaa");
                    //                 date = "2023-03-03";
                    //                 fetchHome();
                    //               });
                    //             },
                    //             child: Container(
                    //               width: 50,
                    //               height: 50,
                    //               decoration: BoxDecoration(
                    //                 border: Border.all(width: 2, color: light),
                    //                 borderRadius: const BorderRadius.all(
                    //                     Radius.circular(8)),
                    //               ),
                    //               child: Column(
                    //                 children: <Widget>[
                    //                   Padding(
                    //                     padding: const EdgeInsets.only(
                    //                         left: 9, top: 5, right: 5),
                    //                     child: Column(
                    //                       children: [
                    //                         Text(

                    //                           '${items[index]}',

                    //                           // Text(
                    //                           //   'Mon',
                    //                           style: TextStyle(

                    //                               color: grey,
                    //                               fontSize: 14,
                    //                               fontWeight: FontWeight.w400,
                    //                               fontFamily: 'NunitoSans'),
                    //                         ),
                    //                         Text(
                    //                           '24',
                    //                           style: TextStyle(
                    //                               color: black,
                    //                               fontSize: 16,
                    //                               fontWeight: FontWeight.w600,
                    //                               fontFamily: 'NunitoSans'),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       }),
                    // ),
                    users.length == 0
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
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 5),
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
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25)),
                                        child: Container(
                                            height: 240,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2, color: grey),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    // CachedNetworkImage(
                                                    //   key: UniqueKey(),
                                                    //   cacheManager: cacheManager,
                                                    //   imageUrl: user.stadiumImage,
                                                    Image.network(
                                                      user.stadiumImage,
                                                      // user.stadiumImage,

                                                      // Image.asset(
                                                      //   'assets/images/stadium2.webp',
                                                      // errorBuilder: (BuildContext
                                                      //         context,
                                                      //     Object exception,
                                                      //     StackTrace? stackTrace) {
                                                      //   return const Text('😢');
                                                      // },
                                                      // errorBuilder: (context,
                                                      //         exception,
                                                      //         stackTrack) =>
                                                      //     Center(
                                                      //   child: Icon(
                                                      //     Icons.error,
                                                      //   ),
                                                      // ),
                                                      // loadingBuilder: (context,
                                                      //         exception,
                                                      //         stackTrack) =>
                                                      //     Center(
                                                      //         child:
                                                      //             CircularProgressIndicator()),
                                                      // errorBuilder: (context, error,
                                                      //     stackTrace) {
                                                      //   return Text(
                                                      //     'Whoops!',
                                                      //     style: TextStyle(
                                                      //         color: black,
                                                      //         fontSize: 30),
                                                      //   );
                                                      // },
                                                      height: 172,
                                                      width: 373,
                                                      color: black
                                                          .withOpacity(0.9),
                                                      fit: BoxFit.fill,
                                                      colorBlendMode:
                                                          BlendMode.dstATop,
                                                    ),
                                                    Positioned(
                                                      top: 12,
                                                      right: 14,
                                                      child: Container(
                                                        height: 17,
                                                        width: 92,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            // user.gameTittle,
                                                            'Hurry! 2Slot left',

                                                            style: TextStyle(
                                                                color: white,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 14,
                                                      right: 8,
                                                      child: Container(
                                                        height: 21,
                                                        width: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: green,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            '4.5',
                                                            style: TextStyle(
                                                                color: white,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 14,
                                                      bottom: 14,
                                                      child: Text(
                                                        user.time,
                                                        // '10 AM  ',
                                                        style: TextStyle(
                                                            color: white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 70,
                                                      bottom: 14,
                                                      child: Text(
                                                        '₹ '
                                                        '${user.price}',
                                                        // '₹ 220',
                                                        style: TextStyle(
                                                            color: white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 14, top: 12),
                                                  child: Text(
                                                    '${users[index].stadiumName}'
                                                    '${','}'
                                                    '${users[index].stateName}',
                                                    // 'Talkatora Indoor Stadium, New Delhi',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 14, top: 5),
                                                  child: Text(
                                                    ' ${users[index].gameType}  '
                                                    '\u2022 '
                                                    '${users[index].status}  '
                                                    '\u2022 '
                                                    '${users[index].maxPlayer}',
                                                    // '5A Side : Open : Max 10 Players by ranjeet1137',
                                                    style: TextStyle(
                                                        color: tab,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                )
                                              ],
                                            )))),
                                // )
                                // )
                              );
                            }),

                    // Padding(
                    //   padding: const EdgeInsets.only(left: 16, right: 16),
                    //   child: Container(
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(top: 14),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               SizedBox(
                    //                 width: 274,
                    //                 height: 44,
                    //                 child: TextField(
                    //                   decoration: InputDecoration(
                    //                       fillColor: light,
                    //                       filled: true,
                    //                       enabledBorder: OutlineInputBorder(
                    //                           borderSide: const BorderSide(
                    //                               width: 3, color: Colors.transparent),
                    //                           borderRadius: BorderRadius.circular(24)),
                    //                       focusedBorder: OutlineInputBorder(
                    //                           borderSide: const BorderSide(color: grey),
                    //                           borderRadius: BorderRadius.circular(24)),
                    //                       contentPadding: const EdgeInsets.only(left: 20),
                    //                       hintText: 'Search',
                    //                       hintStyle: const TextStyle(
                    //                           fontSize: 14,
                    //                           fontFamily: 'NunitoSans',
                    //                           fontWeight: FontWeight.w400,
                    //                           fontStyle: FontStyle.normal)),
                    //                 ),
                    //               ),
                    //               Container(
                    //                 height: 44,
                    //                 width: 44,
                    //                 decoration: BoxDecoration(
                    //                   color: light,
                    //                   border: Border.all(width: 2, color: Colors.transparent),
                    //                   borderRadius: const BorderRadius.all(
                    //                     Radius.circular(100),
                    //                   ),
                    //                 ),
                    //                 child: IconButton(
                    //                     onPressed: () {},
                    //                     icon: Image.asset(
                    //                       'assets/images/setting.png',
                    //                       width: 25,
                    //                       height: 20,
                    //                     )),
                    //               ),
                    //             ],
                    //           ),
                    //           const SizedBox(
                    //             height: 18,
                    //           ),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: const [
                    //               Text(
                    //                 'Featured',
                    //                 style: TextStyle(
                    //                     color: black,
                    //                     fontFamily: 'IBMPlexSans',
                    //                     fontSize: 16,
                    //                     fontWeight: FontWeight.w600,
                    //                     fontStyle: FontStyle.normal),
                    //               ),
                    //               Text(
                    //                 "See all",
                    //                 style: TextStyle(
                    //                     color: red,
                    //                     fontFamily: 'NunitoSans',
                    //                     fontSize: 15,
                    //                     fontWeight: FontWeight.w500,
                    //                     fontStyle: FontStyle.normal),
                    //               )
                    //             ],
                    //           ),
                    //           const SizedBox(
                    //             height: 20,
                    //           ),
                    //           Stack(
                    //             children: [
                    //               Container(
                    //                 height: 130,
                    //                 width: 360,
                    //                 decoration: BoxDecoration(
                    //                   gradient: const LinearGradient(colors: [
                    //                     black,
                    //                     Colors.transparent,
                    //                   ]),
                    //                   image: DecorationImage(
                    //                       image: const AssetImage(
                    //                         'assets/images/stadium1.jpeg',
                    //                       ),
                    //                       colorFilter: ColorFilter.mode(
                    //                           black.withOpacity(0.3), BlendMode.darken),
                    //                       fit: BoxFit.cover),
                    //                   border: Border.all(width: 2, color: Colors.transparent),
                    //                   borderRadius: const BorderRadius.all(
                    //                     Radius.circular(20),
                    //                   ),
                    //                 ),
                    //                 // child: Image.asset(name),
                    //               ),
                    //               const Positioned(
                    //                 top: 25,
                    //                 left: 16,
                    //                 child: Text(
                    //                   'We going ',
                    //                   style: TextStyle(
                    //                       color: white,
                    //                       fontFamily: 'IBMPlexSans',
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.w500,
                    //                       fontStyle: FontStyle.normal),
                    //                 ),
                    //               ),
                    //               const Positioned(
                    //                 // top: 35,
                    //                 left: 16,
                    //                 bottom: 52,
                    //                 child: Text(
                    //                   'International!',
                    //                   style: TextStyle(
                    //                       color: white,
                    //                       fontFamily: 'IBMPlexSans',
                    //                       fontSize: 22,
                    //                       fontWeight: FontWeight.w500,
                    //                       fontStyle: FontStyle.normal),
                    //                 ),
                    //               ),
                    //               const Positioned(
                    //                 bottom: 27,
                    //                 left: 16,
                    //                 child: Text(
                    //                   'Kick to know more :)',
                    //                   style: TextStyle(
                    //                       color: white,
                    //                       fontFamily: 'IBMPlexSans',
                    //                       fontSize: 10,
                    //                       fontWeight: FontWeight.w500,
                    //                       fontStyle: FontStyle.normal),
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //           const SizedBox(
                    //             height: 20,
                    //           ),
                    //           // SingleChildScrollView(
                    //           //   child: Container(
                    //           //       child: ListView.builder(
                    //           //           shrinkWrap: true,
                    //           //           scrollDirection: Axis.horizontal,
                    //           //           // itemCount: ,
                    //           //           itemBuilder: (context, index) {
                    //           //             return Card(
                    //           //               child: Text('data'),
                    //           //             );
                    //           //           })),
                    //           // )
                    //           SizedBox(
                    //             height: 70,
                    //             width: MediaQuery.of(context).size.width,
                    //             child: ListView.builder(
                    //                 scrollDirection: Axis.horizontal,
                    //                 physics: const ClampingScrollPhysics(),
                    //                 shrinkWrap: false,
                    //                 itemCount: 7,
                    //                 itemBuilder: (BuildContext context, int index) {
                    //                   return Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Container(
                    //                       width: 50,
                    //                       height: 50,
                    //                       decoration: BoxDecoration(
                    //                         border: Border.all(width: 2, color: light),
                    //                         borderRadius:
                    //                             const BorderRadius.all(Radius.circular(8)),
                    //                       ),
                    //                       child: Column(
                    //                         children: <Widget>[
                    //                           Padding(
                    //                             padding: const EdgeInsets.only(
                    //                                 left: 9, top: 5, right: 5),
                    //                             child: Column(
                    //                               children: const [
                    //                                 Text(
                    //                                   'Date',
                    //                                   style: TextStyle(
                    //                                       color: grey,
                    //                                       fontSize: 14,
                    //                                       fontWeight: FontWeight.w400,
                    //                                       fontFamily: 'NunitoSans'),
                    //                                 ),
                    //                                 Text(
                    //                                   '24',
                    //                                   style: TextStyle(
                    //                                       color: black,
                    //                                       fontSize: 16,
                    //                                       fontWeight: FontWeight.w600,
                    //                                       fontFamily: 'NunitoSans'),
                    //                                 )
                    //                               ],
                    //                             ),
                    //                           )
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   );
                    //                 }),
                    //           ),

                    //           Expanded(
                    //             child: ListView.builder(
                    //                 physics: const ClampingScrollPhysics(),
                    //                 shrinkWrap: true,
                    //                 scrollDirection: Axis.vertical,
                    //                 itemCount: 5,
                    //                 itemBuilder: (BuildContext context, int index) {
                    //                   return Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: ClipRRect(
                    //                         borderRadius: const BorderRadius.only(
                    //                             topLeft: Radius.circular(25),
                    //                             topRight: Radius.circular(25)),
                    //                         // bottomLeft: Radius.circular(20),
                    //                         // bottomRight: Radius.circular(20)),
                    //                         child: Container(
                    //                             height: 240,
                    //                             // height: 210,
                    //                             decoration: BoxDecoration(
                    //                               border: Border.all(width: 2, color: grey),
                    //                               borderRadius: const BorderRadius.all(
                    //                                   Radius.circular(20)),
                    //                             ),

                    //                             // child: ClipRRect(
                    //                             //     borderRadius: BorderRadius.circular(6),
                    //                             // child: Card(
                    //                             //     semanticContainer: true,
                    //                             child: Column(
                    //                               crossAxisAlignment:
                    //                                   CrossAxisAlignment.start,
                    //                               children: [
                    //                                 Image.asset(
                    //                                   'assets/images/stadium2.webp',
                    //                                   height: 172,
                    //                                   width: 373,
                    //                                   color: black.withOpacity(0.9),
                    //                                   fit: BoxFit.fill,
                    //                                   colorBlendMode: BlendMode.dstATop,
                    //                                 ),
                    //                                 const Padding(
                    //                                   padding:
                    //                                       EdgeInsets.only(left: 14, top: 12),
                    //                                   child: Text(
                    //                                     'Talkatora Indoor Stadium, New Delhi',
                    //                                     style: TextStyle(
                    //                                         fontSize: 14,
                    //                                         fontWeight: FontWeight.w600),
                    //                                   ),
                    //                                 ),
                    //                                 const Padding(
                    //                                   padding:
                    //                                       EdgeInsets.only(left: 14, top: 5),
                    //                                   child: Text(
                    //                                       '5A Side : Open : Max 10 Players by ranjeet1137'),
                    //                                 )
                    //                               ],
                    //                             ))),
                    //                     // )
                    //                     // )
                    //                   );
                    //                 }),
                    //           ),

                    // SizedBox(
                    //   height: 20,
                    // ),

                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.height,
                    //   child: ListView.builder(
                    //       // itemCount: product.length,
                    //       itemBuilder: ((context, index) => Container(
                    //             height: 100,
                    //             color: black,
                    //             child: Padding(
                    //               padding: const EdgeInsets.only(
                    //                   left: 20, right: 20, top: 20),
                    //               child: Card(
                    //                   // margin: const EdgeInsets.all(10),
                    //                   shape: RoundedRectangleBorder(
                    //                       side: BorderSide(width: 1),
                    //                       borderRadius: BorderRadius.circular(10)),
                    //                   child: ListTile(
                    //                       // tileColor: Colors.grey,
                    //                       // leading: Text('da',
                    //                       //   // product[index],
                    //                       //   style: TextStyle(
                    //                       //       fontSize: 18, fontWeight: FontWeight.w500),
                    //                       // ),
                    //                       // title: Text(
                    //                       //   date[index],
                    //                       //   textAlign: TextAlign.center,
                    //                       //   style: TextStyle(
                    //                       //     fontSize: 18,
                    //                       //     fontWeight: FontWeight.w500,
                    //                       //   ),
                    //                       // ),
                    //                       // trailing: Text(
                    //                       //   earn[index],
                    //                       //   style: TextStyle(
                    //                       //       fontSize: 18, fontWeight: FontWeight.w500),
                    //                       // ),
                    //                       )),
                    //             ),
                    //           ))),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ]));
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
}
