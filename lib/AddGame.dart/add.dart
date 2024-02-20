import 'package:flutter/material.dart';
import 'package:footyaddicts/Navigation.dart';
import 'package:footyaddicts/constant/color.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: white,
        leadingWidth: 20,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Navigation()),
            );
          },
          child: Icon(
            Icons.chevron_left,
            color: black,
          ),
        ),
        title: Text(
          'Add a Game',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 14,
              ),
              TextField(
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
                    hintText: 'Search match location',
                    hintStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal)),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'Popular locations in your city',
                style: TextStyle(
                    color: tab,
                    fontFamily: 'NunitoSans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}
