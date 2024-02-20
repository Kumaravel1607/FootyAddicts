import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footyaddicts/constant/color.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool valNotify1 = false;
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
