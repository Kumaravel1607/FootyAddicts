import 'package:flutter/material.dart';
import 'package:footyaddicts/constant/color.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Utkarsh Kumar has just joined your game.',
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: black),
                ),
                subtitle: Text(
                  '08:17 PM',
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: greylite),
                ),
                trailing: Icon(
                  Icons.circle,
                  color: red,
                  size: 15,
                ),
              ),
              Divider(
                height: 5,
                thickness: 0.5,
                color: grey,
              ),
              ListTile(
                title: Text(
                  'Anmol Rai has just joined your game.',
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: black),
                ),
                subtitle: Text(
                  '05:16 PM',
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: greylite),
                ),
                trailing: Icon(
                  Icons.circle,
                  color: red,
                  size: 15,
                ),
              ),
              Divider(
                height: 5,
                thickness: 0.5,
                color: grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
