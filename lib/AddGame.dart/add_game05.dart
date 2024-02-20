import 'package:flutter/material.dart';
import 'package:footyaddicts/AddGame.dart/add_game06.dart';
import 'package:footyaddicts/Navigation.dart';
import 'package:footyaddicts/constant/color.dart';

class AddPage3 extends StatefulWidget {
  AddPage3({Key? key}) : super(key: key);

  @override
  State<AddPage3> createState() => _AddPage3State();
}

class _AddPage3State extends State<AddPage3> {
  List<String> option = ['option1', 'option2', 'option3'];
  late String currentOption = '';
  bool? _checkbox = false;
  late String price;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
        body: Form(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Payment for the game',
                            style: TextStyle(
                                fontFamily: 'Nunito Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 110,
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0.0, vertical: 0.0),
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                title: Text(
                                  'Online',
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                leading: Radio(
                                  activeColor: red,
                                  groupValue: currentOption,
                                  value: option[0],
                                  onChanged: ((value) {
                                    setState(() {
                                      currentOption = value.toString();
                                    });
                                  }),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 110,
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0.0, vertical: 0.0),
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                title: Text(
                                  'Offline',
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                leading: Radio(
                                  activeColor: red,
                                  groupValue: currentOption,
                                  value: option[1],
                                  onChanged: ((value) {
                                    setState(() {
                                      currentOption = value.toString();
                                    });
                                  }),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 110,
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                title: Text(
                                  'Free',
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                leading: Radio(
                                  activeColor: red,
                                  groupValue: currentOption,
                                  value: option[2],
                                  onChanged: ((value) {
                                    setState(() {
                                      currentOption = value.toString();
                                    });
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Price per player',
                          style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter Price";
                            }
                            return null;
                          },
                          onSaved: (price) {
                            price = price!;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(color: red, width: 2)),

                            // fillColor: light,
                            // filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: grey),
                                borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: grey),
                                borderRadius: BorderRadius.circular(24)),
                            contentPadding: const EdgeInsets.only(left: 20),
                            hintText: '₹ 200',
                            hintStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w600,
                                color: black,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'You will receive ₹20 per player in your payout',
                          style: TextStyle(
                              color: lite,
                              fontFamily: 'Rubik',
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                activeColor: red,
                                value: _checkbox,
                                onChanged: (val) {
                                  setState(() {
                                    _checkbox = val;
                                  });
                                }),
                            const Text(
                              'Refund if the game is cancelled',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22)),
                          backgroundColor: red,
                          minimumSize: const Size.fromHeight(44),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GameAdded()));
                        },
                        child: const Text(
                          'Add Game',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
