import 'package:flutter/material.dart';
import 'package:footyaddicts/constant/color.dart';

class SecurityScreen extends StatefulWidget {
  SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool valNotify1 = false;
  bool valNotify2 = false;
  bool valNotify3 = false;

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
            'Security',
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
              buildNotificationOption("Face ID", valNotify1, onChangeFunction1),
              Divider(
                height: 10,
                thickness: 0.5,
                color: grey,
              ),
              buildNotificationOption(
                  "Remember me", valNotify2, onChangeFunction2),
              Divider(
                height: 10,
                thickness: 0.5,
                color: grey,
              ),
              buildNotificationOption(
                  "Touch ID", valNotify3, onChangeFunction3),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2,
                        color: red,
                      ),
                      borderRadius: BorderRadius.circular(22)),
                  backgroundColor: white,
                  minimumSize: const Size.fromHeight(44),
                ),
                onPressed: () {
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //         builder: (context) => Redirect()));
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //         builder: (context) => Confirm()));
                },
                child: const Text(
                  'Change Password',
                  style: TextStyle(
                    color: red,
                    fontSize: 16,
                    fontFamily: 'IBMPlexSans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
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
