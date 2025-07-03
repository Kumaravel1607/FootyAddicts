buimport 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footyaddicts/constant/color.dart';

class Notifications1Screen extends StatefulWidget {
  Notifications1Screen({Key? key}) : super(key: key);

  @override
  State<Notifications1Screen> createState() => _Notifications1ScreenState();
}

class _Notifications1ScreenState extends State<Notifications1Screen> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;
  bool valNotify4 = false;
  onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  onChangeFunction4(bool newValue4) {
    setState(() {
      valNotify4 = newValue4;
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
            'Notifications',
            style: TextStyle(
              color: black,
              fontFamily: 'IBMPlexSans',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              buildNotificationOption("Sound", valNotify1, onChangeFunction1),
              Divider(
                height: 10,
                thickness: 0.5,
                color: grey,
              ),
              buildNotificationOption(
                  "Vibration", valNotify2, onChangeFunction2),
              Divider(
                height: 10,
                thickness: 0.5,
                color: grey,
              ),
              buildNotificationOption(
                  "New tips available", valNotify3, onChangeFunction3),
              Divider(
                height: 10,
                thickness: 0.5,
                color: grey,
              ),
              buildNotificationOption(
                  "New service available", valNotify4, onChangeFunction4)
            ],
          ),
        ));
  }

  Padding buildNotificationOption(
      String title, bool value, Function onChangedMethod) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: 'NunitoSans',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: liteblack),
          ),
          Transform.scale(
            scale: 1.0,
            child: Switch(
                activeColor: red,
                value: value,
                onChanged: (bool newValue) {
                  onChangedMethod(newValue);
                }),
          )
        ],
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:footyaddicts/constant/color.dart';
// import 'package:footyaddicts/games_02.dart';
// import 'package:footyaddicts/models/home_page.dart';
// import 'package:footyaddicts/notification.dart';
// import 'package:footyaddicts/services/Services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:date_picker_timeline/date_picker_timeline.dart';
// import 'package:intl/intl.dart';

// class Games extends StatefulWidget {
//   Games({Key? key}) : super(key: key);

//   @override
//   State<Games> createState() => _GamesState();
// }

// class _GamesState extends State<Games> {
//   DatePickerController _controller = DatePickerController();

//   DateTime _selectedValue = DateTime.now();

//   bool _validate = false;
//   var date = "";
//   @override
//   void dispose() {
//     super.dispose();
//   }

//   late List<Datum> users = [];

//   @override
//   void initState() {
//     super.initState();
//     // users = [];
//     fetchHome();
//   }

//   fetchHome() async {
//     SharedPreferences session = await SharedPreferences.getInstance();
//     print("--------");
//     var email = session.getString('email');

//     print("--------");
//     print(email);
//     print(date);
//     Services.fetchHome(date).then((results) {
//       setState(() {
//         users = results;

//         //print(users[0].gameTittle);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: white,
//           centerTitle: false,
//           leadingWidth: 0,
//           elevation: 1,
//           title: const Text(
//             'My Games',
//             style: TextStyle(
//                 color: black,
//                 fontSize: 16,
//                 fontFamily: 'IBMPlexSans',
//                 fontWeight: FontWeight.w500),
//           ),
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: ((context) => NotificationPage())));
//                 },
//                 icon: Image.asset(
//                   'assets/images/Notification.png',
//                   width: 18,
//                   height: 20,
//                 ))
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 16, right: 16),
//             child: Container(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 14),
//                     child: TextField(
//                       decoration: InputDecoration(
//                           fillColor: light,
//                           filled: true,
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   width: 3, color: Colors.transparent),
//                               borderRadius: BorderRadius.circular(24)),
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: grey),
//                               borderRadius: BorderRadius.circular(24)),
//                           contentPadding: const EdgeInsets.only(left: 20),
//                           hintText: 'Search',
//                           hintStyle: const TextStyle(
//                               fontSize: 14,
//                               fontFamily: 'NunitoSans',
//                               fontWeight: FontWeight.w400,
//                               fontStyle: FontStyle.normal)),
//                     ),
//                   ),

//                   SizedBox(
//                     height: 10,
//                   ),
//                   // SizedBox(
//                   //   height: 70,
//                   //   width: MediaQuery.of(context).size.width,
//                   //   child: ListView.builder(
//                   //       scrollDirection: Axis.horizontal,
//                   //       physics: const ClampingScrollPhysics(),
//                   //       shrinkWrap: false,
//                   //       itemCount: 7,
//                   //       itemBuilder: (BuildContext context, int index) {
//                   //         return Padding(
//                   //           padding: const EdgeInsets.only(
//                   //               top: 8, right: 8, bottom: 8),
//                   //           child: Container(
//                   //             width: 50,
//                   //             height: 50,
//                   //             decoration: BoxDecoration(
//                   //               border: Border.all(width: 2, color: light),
//                   //               borderRadius:
//                   //                   const BorderRadius.all(Radius.circular(8)),
//                   //             ),
//                   //             child: Column(
//                   //               children: <Widget>[
//                   //                 Padding(
//                   //                   padding: const EdgeInsets.only(
//                   //                       left: 9, top: 5, right: 5),
//                   //                   child: Column(
//                   //                     children: const [
//                   //                       Text(
//                   //                         'Mon',
//                   //                         style: TextStyle(
//                   //                             color: grey,
//                   //                             fontSize: 14,
//                   //                             fontWeight: FontWeight.w400,
//                   //                             fontFamily: 'NunitoSans'),
//                   //                       ),
//                   //                       Text(
//                   //                         '24',
//                   //                         style: TextStyle(
//                   //                             color: black,
//                   //                             fontSize: 16,
//                   //                             fontWeight: FontWeight.w600,
//                   //                             fontFamily: 'NunitoSans'),
//                   //                       )
//                   //                     ],
//                   //                   ),
//                   //                 )
//                   //               ],
//                   //             ),
//                   //           ),
//                   //         );
//                   //       }),
//                   // ),
//                   SizedBox(
//                     height: 80,
//                     child: DatePicker(
//                       DateTime.now(),
//                       width: 50,
//                       height: 60,
//                       controller: _controller,
//                       initialSelectedDate: DateTime.now(),
//                       selectionColor: red,
//                       selectedTextColor: white,
//                       onDateChange: (date_s) {
//                         // New date selected
//                         print(date_s);
//                         print('------');
//                         setState(() {
//                           final f = new DateFormat('yyyy-MM-dd');

//                           date = f.format(date_s);
//                           print(date);
//                           print('......');
//                           fetchHome();
//                         });
//                       },
//                     ),
//                   ),

//                   SizedBox(
//                     height: 10,
//                   ),
//                   // ListView.builder(itemBuilder: (context, index) {
//                   //   return Card(
//                   //     child: Text('data'),
//                   //   );
//                   // })
//                   GestureDetector(
//                     onTap: () {
//                       // Navigator.of(context).pushReplacement(MaterialPageRoute(
//                       //     builder: (BuildContext context) => GameDetails(
//                       //     ,
//                       //     )));
//                     },
//                     child: users.length == 0
//                         ? Text(
//                             "No  Data Found",
//                             style: TextStyle(color: black),
//                           )
//                         : ListView.builder(
//                             physics: const ClampingScrollPhysics(),
//                             shrinkWrap: true,
//                             scrollDirection: Axis.vertical,
//                             itemCount: users.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               final user = users[index];
//                               return Padding(
//                                 padding: const EdgeInsets.only(bottom: 12),
//                                 child: Container(
//                                   height: 140,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: bg, width: 2),

//                                     // border: Border.all(
//                                     //     // Set border color
//                                     //     width: 3.0), // Set border width
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10.0)),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(8),
//                                             bottomLeft: Radius.circular(8)),
//                                         child: Image.network(
//                                           user.stadiumImage,
//                                           //Image.asset(

//                                           // 'assets/images/stadium2.webp',
//                                           width: 116,
//                                           height: 141,
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Text(
//                                             '${user.time}'
//                                             ' • '
//                                             '₹ '
//                                             '${user.price}',
//                                             style: TextStyle(
//                                                 color: tab,
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w400,
//                                                 fontFamily: 'NunitoSans'),
//                                           ),
//                                           Text(
//                                             '${user.stadiumName}'
//                                             ','
//                                             ' \n'
//                                             '${user.stateName}',
//                                             // 'Talkatora Indoor Stadium,\n New Delhi',
//                                             style: TextStyle(
//                                                 color: black,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600,
//                                                 fontFamily: 'NunitoSans'),
//                                           ),
//                                           Text(
//                                             '${user.gameType}'
//                                             ' • '
//                                             '${user.status}'
//                                             ' • '
//                                             '${user.maxPlayer}'
//                                             ' \n',
//                                             // '5A Side : Open : Max 10 Players \n by ranjeet1137',
//                                             style: TextStyle(
//                                                 color: tab,
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }





**KUMARAVEL SHANMUGAM**
Flutter Developer | Team Lead  
Dharmapuri, Tamil Nadu  
Email: kumaraveljoshika29@gmail.com  
Phone: +91 99768 50646 | +91 96773 15169  
GitHub: github.com/Kumaravel1607  
LinkedIn: linkedin.com/in/kums-kumaravel-338154179  

---

**Professional Summary**

Experienced Flutter Developer with over 3 years in mobile app development, currently serving as a Team Lead at Witvo Technologies. Skilled in building cross-platform applications with strong UI/UX, efficient backend integration, and clean architecture. Proven record of publishing live apps on the Play Store and managing development teams. Passionate about performance optimization, scalable coding practices, and modern mobile frameworks.

---

**Professional Experience**

**Team Lead – Flutter Developer**  
Witvo Technologies Pvt. Ltd. – Bangalore  
March 2024 – Present  
- Leading a team of Flutter developers and overseeing full-cycle app development.  
- Project planning, code reviews, architecture decisions, and mentoring junior developers.  
- Live Projects:
  - [Jewel App](https://play.google.com/store/apps/details?id=com.witvotech.JewelApp)
  - [Chandra Jewellers](https://play.google.com/store/apps/details?id=com.witvotech.chandrajewellers)
  - [SS Jewellers](https://play.google.com/store/apps/details?id=com.witvotech.ssjewellery)
  - [Witvo Expense Manager Offline](https://play.google.com/store/apps/details?id=com.witvotech.expensemanager)
  - [WO FM](https://play.google.com/store/apps/details?id=com.witvotech.wofm)
  - [SRA Reward Manager](https://play.google.com/store/apps/details?id=com.witvotech.srarewards)
  - [TTS](https://play.google.com/store/apps/details?id=com.witvotech.wotts)
  - [Reminder](https://play.google.com/store/apps/details?id=com.witvotech.wo_reminder)
  - [WO Games](https://play.google.com/store/apps/details?id=com.witvotech.wokidsgamezone)
  - Asrithas Group (Play Store)
  - GooAds (Play Store)

**Flutter Developer**  
Hashref Software Technology Pvt. Ltd. – Coimbatore  
January 2022 – March 2024  
- Developed full-featured mobile applications across EdTech, Real Estate, and Classifieds.  
- Collaborated with designers, QA, and backend teams to deliver high-quality products.  
- Major Projects:
  - Expense Manager (Offline) – Local storage using SQLite and Hive.  
  - Digital Gold Saving App – Investment app with live gold pricing and secure transactions.  
  - Reward Points Management App – Digital wallet and rewards system.  
  - MtiDesk – Real-time student attendance tracking.  
  - MtiSoft – Attendance app with backend sync.  
  - Asrithas Group – Real estate app.  
  - GooAds – Multi-city classifieds.  
  - Glocal Bizz – Product ads for B2C and C2C.  

---

**Key Skills**

- **Languages & Frameworks:** Dart, Flutter, HTML, CSS  
- **Mobile Development:** Android & iOS (cross-platform)  
- **Storage:** SQLite, Hive, Firebase  
- **Backend Integration:** REST APIs, Firebase  
- **API Development:** Basic PHP API  
- **Tools:** Git, GitHub, Android Studio  
- **Soft Skills:** Leadership, Communication, Problem Solving  
- **Focus Areas:** Clean Architecture, Offline/Online Storage, Team Collaboration

---

**Education**

**Bachelor of Engineering – Computer Science and Engineering**  
KPR Institute of Engineering and Technology, Coimbatore  
2016 – 2020 | CGPA: 6.8  

**HSC (Higher Secondary Certificate)**  
Paramveer Matriculation Hr. Sec. School, Dharmapuri  
2016 | 78.25%  

**SSLC (Secondary School Leaving Certificate)**  
Paramveer Matriculation Hr. Sec. School, Dharmapuri  
2014 | 93.6%

---

**Certifications**

- HTML & CSS – SoloLearn  
- Step into Robotic Process Automation (RPA) – GUVI (Oracle Certified)