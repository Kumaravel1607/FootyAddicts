import 'package:flutter/material.dart';
import 'package:footyaddicts/Edit.dart';
import 'package:footyaddicts/Logout.dart';
import 'package:footyaddicts/Notifications.dart';
import 'package:footyaddicts/AddGame.dart/add_game03.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/login.dart';
import 'package:footyaddicts/notification.dart';
import 'package:footyaddicts/security.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        titleSpacing: -30,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: black,
            fontFamily: 'IBMPlexSans',
            fontWeight: FontWeight.w500,
            fontSize: 16,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      height: 130,
                      width: 380,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 35,
                                    backgroundImage:
                                        AssetImage('assets/images/av.png'),
                                  ),
                                  title: const Text(
                                    'Joshep Vijay',
                                    style: TextStyle(
                                      color: black,
                                      fontFamily: 'IBMPlexSans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: const Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse lectus ligula',
                                    style: TextStyle(
                                      fontFamily: 'IBMPlexSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  menubox(Icons.person_outline, "Edit Profile", EditScreen()),
                  Divider(
                    height: 5,
                    thickness: 0.5,
                    color: grey,
                  ),
                  menubox(Icons.notifications_outlined, "Notifications",
                      NotificationsScreen()),
                  Divider(
                    height: 5,
                    thickness: 0.5,
                    color: grey,
                  ),
                  menubox(Icons.lock_outline, "Security", SecurityScreen()),
                  Divider(
                    height: 5,
                    thickness: 0.5,
                    color: grey,
                  ),
                  // menubox(Icons.logout_outlined, "LogOut", logout()),
                  SizedBox(
                    height: 10,
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
                                height: 180,
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
                                              'Log out',
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
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Are you sure you want to logout?',
                                          style: TextStyle(
                                              fontFamily: 'NunitoSans',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: tab),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              22)),
                                                  backgroundColor: white,
                                                  minimumSize:
                                                      const Size.fromHeight(44),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LogScreen()));
                                                },
                                                child: const Text(
                                                  'Yes Logout',
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              22)),
                                                  backgroundColor: red,
                                                  minimumSize:
                                                      const Size.fromHeight(44),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProfilePage()));
                                                },
                                                child: const Text(
                                                  'Cancel',
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
                                ),
                              ),
                            );
                          });
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.logout_outlined,
                        color: red,
                        size: 30,
                      ),
                      title: Transform.translate(
                        offset: Offset(-10, 0),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'NunitoSans'),
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: black,
                      ),
                    ),
                  ),
                  Divider(
                    height: 5,
                    thickness: 0.5,
                    color: grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menubox(image_icon, title, go_screen) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => go_screen));
      },
      child: ListTile(
        leading: Icon(
          image_icon,
          color: red,
          size: 30,
        ),
        title: Transform.translate(
          offset: Offset(-10, 0),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'NunitoSans'),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: black,
        ),
      ),
    );
  }
}
