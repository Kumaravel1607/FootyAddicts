// import 'package:flutter/material.dart';
// import 'constant/color.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // final titles = [
//   //   "Talkatora Indoor Stadium, New Delhi",
//   //   "Talkatora Indoor Stadium, New Delhi",
//   //   "Talkatora Indoor Stadium, New Delhi"
//   // ];
//   // final subtitles = [
//   //   "Here is list 1 subtitle",
//   //   "Here is list 2 subtitle",
//   //   "Here is list 3 subtitle"
//   // ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(title: Text('data')),
//         body: CustomScrollView(slivers: [
//       SliverAppBar(
//         backgroundColor: white,
//         pinned: true,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 16),
//           child: Image.asset(
//             'assets/images/FootyConnect1.png',
//             width: 31,
//             height: 36,
//           ),
//         ),
//         titleSpacing: 2,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 6),
//           child: Image.asset(
//             'assets/images/FootyConnect3.png',
//             height: 11,
//             width: 126,
//           ),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: Image.asset(
//                 'assets/images/Notification.png',
//                 width: 18,
//                 height: 20,
//               ))
//         ],
//       ),
//       SliverToBoxAdapter(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 16, right: 16),
//           child: Container(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: 274,
//                         height: 44,
//                         child: TextField(
//                           decoration: InputDecoration(
//                               fillColor: light,
//                               filled: true,
//                               enabledBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                       width: 3, color: Colors.transparent),
//                                   borderRadius: BorderRadius.circular(24)),
//                               focusedBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(color: grey),
//                                   borderRadius: BorderRadius.circular(24)),
//                               contentPadding: const EdgeInsets.only(left: 20),
//                               hintText: 'Search',
//                               hintStyle: const TextStyle(
//                                   fontSize: 14,
//                                   fontFamily: 'NunitoSans',
//                                   fontWeight: FontWeight.w400,
//                                   fontStyle: FontStyle.normal)),
//                         ),
//                       ),
//                       Container(
//                         height: 44,
//                         width: 44,
//                         decoration: BoxDecoration(
//                           color: light,
//                           border:
//                               Border.all(width: 2, color: Colors.transparent),
//                           borderRadius: const BorderRadius.all(
//                             Radius.circular(100),
//                           ),
//                         ),
//                         child: IconButton(
//                             onPressed: () {},
//                             icon: Image.asset(
//                               'assets/images/setting.png',
//                               width: 25,
//                               height: 20,
//                             )),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Text(
//                         'Featured',
//                         style: TextStyle(
//                             color: black,
//                             fontFamily: 'IBMPlexSans',
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             fontStyle: FontStyle.normal),
//                       ),
//                       Text(
//                         "See all",
//                         style: TextStyle(
//                             color: red,
//                             fontFamily: 'NunitoSans',
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             fontStyle: FontStyle.normal),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Stack(
//                     children: [
//                       Container(
//                         height: 130,
//                         width: 360,
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(colors: [
//                             black,
//                             Colors.transparent,
//                           ]),
//                           image: DecorationImage(
//                               image: const AssetImage(
//                                 'assets/images/stadium1.jpeg',
//                               ),
//                               colorFilter: ColorFilter.mode(
//                                   black.withOpacity(0.3), BlendMode.darken),
//                               fit: BoxFit.cover),
//                           border:
//                               Border.all(width: 2, color: Colors.transparent),
//                           borderRadius: const BorderRadius.all(
//                             Radius.circular(20),
//                           ),
//                         ),
//                         // child: Image.asset(name),
//                       ),
//                       const Positioned(
//                         top: 25,
//                         left: 16,
//                         child: Text(
//                           'We going ',
//                           style: TextStyle(
//                               color: white,
//                               fontFamily: 'IBMPlexSans',
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               fontStyle: FontStyle.normal),
//                         ),
//                       ),
//                       const Positioned(
//                         // top: 35,
//                         left: 16,
//                         bottom: 52,
//                         child: Text(
//                           'International!',
//                           style: TextStyle(
//                               color: white,
//                               fontFamily: 'IBMPlexSans',
//                               fontSize: 22,
//                               fontWeight: FontWeight.w500,
//                               fontStyle: FontStyle.normal),
//                         ),
//                       ),
//                       const Positioned(
//                         bottom: 27,
//                         left: 16,
//                         child: Text(
//                           'Kick to know more :)',
//                           style: TextStyle(
//                               color: white,
//                               fontFamily: 'IBMPlexSans',
//                               fontSize: 10,
//                               fontWeight: FontWeight.w500,
//                               fontStyle: FontStyle.normal),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   // SingleChildScrollView(
//                   //   child: Container(
//                   //       child: ListView.builder(
//                   //           shrinkWrap: true,
//                   //           scrollDirection: Axis.horizontal,
//                   //           // itemCount: ,
//                   //           itemBuilder: (context, index) {
//                   //             return Card(
//                   //               child: Text('data'),
//                   //             );
//                   //           })),
//                   // )
//                   SizedBox(
//                     height: 70,
//                     width: MediaQuery.of(context).size.width,
//                     child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         physics: const ClampingScrollPhysics(),
//                         shrinkWrap: false,
//                         itemCount: 7,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               width: 50,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 border: Border.all(width: 2, color: light),
//                                 borderRadius:
//                                     const BorderRadius.all(Radius.circular(8)),
//                               ),
//                               child: Column(
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 9, top: 5, right: 5),
//                                     child: Column(
//                                       children: const [
//                                         Text(
//                                           'Date',
//                                           style: TextStyle(
//                                               color: grey,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400,
//                                               fontFamily: 'NunitoSans'),
//                                         ),
//                                         Text(
//                                           '24',
//                                           style: TextStyle(
//                                               color: black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600,
//                                               fontFamily: 'NunitoSans'),
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         }),
//                   ),

//                   ListView.builder(
//                       physics: const ClampingScrollPhysics(),
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       itemCount: 5,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: ClipRRect(
//                               borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(25),
//                                   topRight: Radius.circular(25)),
//                               // bottomLeft: Radius.circular(20),
//                               // bottomRight: Radius.circular(20)),
//                               child: Container(
//                                   height: 240,
//                                   // height: 210,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(width: 2, color: grey),
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(20)),
//                                   ),

//                                   // child: ClipRRect(
//                                   //     borderRadius: BorderRadius.circular(6),
//                                   // child: Card(
//                                   //     semanticContainer: true,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Image.asset(
//                                         'assets/images/stadium2.webp',
//                                         height: 172,
//                                         width: 373,
//                                         color: black.withOpacity(0.9),
//                                         fit: BoxFit.fill,
//                                         colorBlendMode: BlendMode.dstATop,
//                                       ),
//                                       const Padding(
//                                         padding:
//                                             EdgeInsets.only(left: 14, top: 12),
//                                         child: Text(
//                                           'Talkatora Indoor Stadium, New Delhi',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       const Padding(
//                                         padding:
//                                             EdgeInsets.only(left: 14, top: 5),
//                                         child: Text(
//                                             '5A Side : Open : Max 10 Players by ranjeet1137'),
//                                       )
//                                     ],
//                                   ))),
//                           // )
//                           // )
//                         );
//                       }),
//                   // ListView.builder(
//                   //     itemBuilder: (BuildContext context, int index) {
//                   //   return ClipRRect(
//                   //     child: Container(
//                   //         height: 240,
//                   //         child: Column(
//                   //           children: [
//                   //             Image.asset('assets/images/stadium2.webp'),
//                   //             Text(
//                   //               'Talkatora Indoor Stadium, New Delhi',
//                   //               style: TextStyle(
//                   //                   fontSize: 14, fontWeight: FontWeight.w600),
//                   //             ),
//                   //           ],
//                   //         )),
//                   //   );
//                   // })
//                   // Spacer(
//                   //   flex: 1,
//                   // ),

//                   // ListView.builder(
//                   //     physics: const ClampingScrollPhysics(),
//                   //     shrinkWrap: true,
//                   //     scrollDirection: Axis.vertical,
//                   //     itemCount: 5,
//                   //     itemBuilder: (BuildContext context, int index) {
//                   //       return Padding(
//                   //         padding: const EdgeInsets.all(8.0),
//                   //         child: ClipRRect(
//                   //             borderRadius: const BorderRadius.only(
//                   //                 topLeft: Radius.circular(25),
//                   //                 topRight: Radius.circular(25)),
//                   //             // bottomLeft: Radius.circular(20),
//                   //             // bottomRight: Radius.circular(20)),
//                   //             child: Container(
//                   //                 height: 240,
//                   //                 // height: 210,
//                   //                 decoration: BoxDecoration(
//                   //                   border: Border.all(width: 2, color: grey),
//                   //                   borderRadius: const BorderRadius.all(
//                   //                       Radius.circular(20)),
//                   //                 ),

//                   //                 // child: ClipRRect(
//                   //                 //     borderRadius: BorderRadius.circular(6),
//                   //                 // child: Card(
//                   //                 //     semanticContainer: true,
//                   //                 child: Column(
//                   //                   crossAxisAlignment:
//                   //                       CrossAxisAlignment.start,
//                   //                   children: [
//                   //                     Image.asset(
//                   //                       'assets/images/stadium2.webp',
//                   //                       height: 172,
//                   //                       width: 373,
//                   //                       color: black.withOpacity(0.9),
//                   //                       fit: BoxFit.fill,
//                   //                       colorBlendMode: BlendMode.dstATop,
//                   //                     ),
//                   //                     const Padding(
//                   //                       padding:
//                   //                           EdgeInsets.only(left: 14, top: 12),
//                   //                       child: Text(
//                   //                         'Talkatora Indoor Stadium, New Delhi',
//                   //                         style: TextStyle(
//                   //                             fontSize: 14,
//                   //                             fontWeight: FontWeight.w600),
//                   //                       ),
//                   //                     ),
//                   //                     const Padding(
//                   //                       padding:
//                   //                           EdgeInsets.only(left: 14, top: 5),
//                   //                       child: Text(
//                   //                           '5A Side : Open : Max 10 Players by ranjeet1137'),
//                   //                     )
//                   //                   ],
//                   //                 ))),
//                   //         // )
//                   //         // )
//                   //       );
//                   //     }),

//                   // SizedBox(
//                   //   height: 20,
//                   // ),

//                   // Container(
//                   //   width: MediaQuery.of(context).size.width,
//                   //   height: MediaQuery.of(context).size.height,
//                   //   child: ListView.builder(
//                   //       // itemCount: product.length,
//                   //       itemBuilder: ((context, index) => Container(
//                   //             height: 100,
//                   //             color: black,
//                   //             child: Padding(
//                   //               padding: const EdgeInsets.only(
//                   //                   left: 20, right: 20, top: 20),
//                   //               child: Card(
//                   //                   // margin: const EdgeInsets.all(10),
//                   //                   shape: RoundedRectangleBorder(
//                   //                       side: BorderSide(width: 1),
//                   //                       borderRadius: BorderRadius.circular(10)),
//                   //                   child: ListTile(
//                   //                       // tileColor: Colors.grey,
//                   //                       // leading: Text('da',
//                   //                       //   // product[index],
//                   //                       //   style: TextStyle(
//                   //                       //       fontSize: 18, fontWeight: FontWeight.w500),
//                   //                       // ),
//                   //                       // title: Text(
//                   //                       //   date[index],
//                   //                       //   textAlign: TextAlign.center,
//                   //                       //   style: TextStyle(
//                   //                       //     fontSize: 18,
//                   //                       //     fontWeight: FontWeight.w500,
//                   //                       //   ),
//                   //                       // ),
//                   //                       // trailing: Text(
//                   //                       //   earn[index],
//                   //                       //   style: TextStyle(
//                   //                       //       fontSize: 18, fontWeight: FontWeight.w500),
//                   //                       // ),
//                   //                       )),
//                   //             ),
//                   //           ))),
//                   // )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       )
//     ]));
//   }
// }
//       // child: Container(

//       // height: MediaQuery.of(context).size.height,
//       // width: MediaQuery.of(context).size.width,
//       // child: Expanded(
//       //   child: ListView.builder(
//       //       physics: ClampingScrollPhysics(),
//       //       shrinkWrap: true,
//       //       scrollDirection: Axis.vertical,
//       //       itemCount: 10,
//       //       itemBuilder: (BuildContext context, int index) {
//       //         return Padding(
//       //           padding: const EdgeInsets.all(8.0),
//       //           child: ClipRRect(
//       //               borderRadius: BorderRadius.only(
//       //                   topLeft: Radius.circular(25),
//       //                   topRight: Radius.circular(25)),
//       //               // bottomLeft: Radius.circular(20),
//       //               // bottomRight: Radius.circular(20)),
//       //               child: Container(
//       //                   height: 240,
//       //                   // height: 210,
//       //                   decoration: BoxDecoration(
//       //                     border: Border.all(width: 2, color: grey),
//       //                     borderRadius:
//       //                         BorderRadius.all(Radius.circular(20)),
//       //                   ),

//       //                   // child: ClipRRect(
//       //                   //     borderRadius: BorderRadius.circular(6),
//       //                   // child: Card(
//       //                   //     semanticContainer: true,
//       //                   child: Column(
//       //                     crossAxisAlignment: CrossAxisAlignment.start,
//       //                     children: [
//       //                       Image.asset(
//       //                         'assets/images/stadium2.webp',
//       //                         height: 172,
//       //                         width: 373,
//       //                         color: black.withOpacity(0.9),
//       //                         fit: BoxFit.fill,
//       //                         colorBlendMode: BlendMode.dstATop,
//       //                       ),
//       //                       Padding(
//       //                         padding:
//       //                             const EdgeInsets.only(left: 14, top: 12),
//       //                         child: Text(
//       //                           'Talkatora Indoor Stadium, New Delhi',
//       //                           style: TextStyle(
//       //                               fontSize: 14,
//       //                               fontWeight: FontWeight.w600),
//       //                         ),
//       //                       ),
//       //                       Padding(
//       //                         padding:
//       //                             const EdgeInsets.only(left: 14, top: 5),
//       //                         child: Text(
//       //                             'Talkatora Indoor Stadium, New Delhi'),
//       //                       )
//       //                     ],
//       //                   ))),
//       //           // )
//       //           // )
//       //         );
//       //       }),
//       // ),
//       // )
