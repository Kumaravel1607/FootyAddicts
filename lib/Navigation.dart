// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footyaddicts/Home_page.dart';
import 'package:footyaddicts/AddGame.dart/add.dart';
import 'package:footyaddicts/AddGame.dart/add_game03.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/games_01.dart';
// import 'package:footyaddicts/home.dart';

import 'package:footyaddicts/home1.dart';
import 'package:footyaddicts/notification.dart';
import 'package:footyaddicts/profile.dart';

class Navigation extends StatefulWidget {
  Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var tabIndex = 0;
  void changeTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: tabIndex,
        children: [
          HomeScreen(),
          Games(),
          HomeScreen(),
          NotificationPage(),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        notchMargin: 4,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          currentIndex: tabIndex,
          onTap: changeTab,
          selectedItemColor: red,
          unselectedItemColor: tab,
          items: [
            itemBar(Icons.home, 'Home'),
            itemBar(Icons.sports_soccer, 'My Games'),
            const BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(
                  Icons.home,
                  color: Colors.transparent,
                ),
                label: ''),
            itemBar(Icons.notifications_outlined, 'Notification'),
            itemBar(Icons.account_circle_outlined, 'Profile')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: red,
        focusColor: Colors.transparent,
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddPage1())),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

itemBar(IconData icon, String label) {
  return BottomNavigationBarItem(icon: Icon(icon), label: label);
}
