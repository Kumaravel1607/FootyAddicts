import 'package:flutter/material.dart';

class Sample extends StatefulWidget {
  Sample({Key? key}) : super(key: key);

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 150,
      child: ListView.builder(
          // physics: const ClampingScrollPhysics(),
          // shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 40,
                foregroundImage: AssetImage(
                  'assets/images/av.png',
                ),
              ),
            );
          }),
    ));
  }
}
