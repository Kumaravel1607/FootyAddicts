import 'package:flutter/material.dart';
import 'package:footyaddicts/AddGame.dart/add_game03.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/home1.dart';
import 'package:footyaddicts/login.dart';
import 'package:footyaddicts/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutScreen extends StatefulWidget {
  LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  var focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
                      bottom: MediaQuery.of(context).viewInsets.bottom),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            padding: const EdgeInsets.only(right: 16),
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
                                          borderRadius:
                                              BorderRadius.circular(22)),
                                      backgroundColor: white,
                                      minimumSize: const Size.fromHeight(44),
                                    ),
                                    onPressed: () async {
                                      // Obtain shared preferences.
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      // Remove data for the 'counter' key.
                                      await prefs.remove('email');
                                      await prefs.remove('user_id');
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
                                              BorderRadius.circular(22)),
                                      backgroundColor: red,
                                      minimumSize: const Size.fromHeight(44),
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
      ),
    );
  }
}
