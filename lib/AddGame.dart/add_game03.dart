import 'package:flutter/material.dart';
import 'package:footyaddicts/AddGame.dart/add_game04.dart';
import 'package:footyaddicts/Navigation.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddPage1 extends StatefulWidget {
  AddPage1({Key? key}) : super(key: key);

  @override
  State<AddPage1> createState() => _AddPage1State();
}

class _AddPage1State extends State<AddPage1> {
  // late TimeOfDay timeofDay;
  late String date, time;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController.text = '';
    timeController.text = '';
    // timeofDay = TimeOfDay.now();
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
        body: Form(
          key: formkey,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Select date and time of the game',
                        style: TextStyle(
                          color: black,
                          fontFamily: 'NunitoSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Date',
                        style: TextStyle(
                          color: black,
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter date";
                          }
                          return null;
                        },
                        onSaved: (date) {
                          date = date!;
                        },
                        onTap: () async {
                          DateTime? datePicked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2010),
                            lastDate: DateTime(2100),
                          );

                          if (datePicked != null) {
                            String formattedDate =
                                DateFormat("dd-MM-yyyy").format(datePicked);
                            setState(() {
                              dateController.text = formattedDate.toString();
                            });
                          }
                        },
                        controller: dateController,
                        decoration: InputDecoration(
                            // fillColor: light,
                            // filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(color: red, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: grey),
                                borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: grey),
                                borderRadius: BorderRadius.circular(24)),
                            contentPadding: const EdgeInsets.only(left: 20),
                            // hintText: 'Date-Month-Year',
                            // hintStyle: const TextStyle(
                            //     fontSize: 14,
                            //     fontFamily: 'NunitoSans',
                            //     fontWeight: FontWeight.w400,
                            //     fontStyle: FontStyle.normal),
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  DateTime? datePicked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime(2100),
                                  );

                                  if (datePicked != null) {
                                    String formattedDate =
                                        DateFormat("dd-MM-yyyy")
                                            .format(datePicked);
                                    setState(() {
                                      dateController.text =
                                          formattedDate.toString();
                                    });
                                  }
                                  // print(
                                  //     'Date Selected: ${datePicked.day}-${datePicked.month}-${datePicked.year}');
                                },
                                icon: Icon(Icons.calendar_today,
                                    color: greylite))),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Time',
                        style: TextStyle(
                          color: black,
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter time";
                          }
                          return null;
                        },
                        onSaved: (time) {
                          time = time!;
                        },
                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.input);
                          if (pickedTime != null) {
                            setState(() {
                              MaterialLocalizations localizations =
                                  MaterialLocalizations.of(context);
                              String formattedTime =
                                  localizations.formatTimeOfDay(pickedTime,
                                      alwaysUse24HourFormat: false);

                              timeController.text = formattedTime.toString();
                              // String formattedtime = DateFormat('hh:mm a')
                              //     .format(pickedTime);
                              // timeController.text =
                              //     formattedtime.toString();
                            });
                          }
                        },
                        controller: timeController,
                        decoration: InputDecoration(
                            // fillColor: light,
                            // filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(color: red, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: grey),
                                borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: grey),
                                borderRadius: BorderRadius.circular(24)),
                            contentPadding: const EdgeInsets.only(left: 20),
                            hintText: 'Time',
                            hintStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal),

                            // suffixIcon: Icon(Icons.access_time, color: greylite)
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  final TimeOfDay? pickedTime =
                                      await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          initialEntryMode:
                                              TimePickerEntryMode.input);
                                  if (pickedTime != null) {
                                    setState(() {
                                      MaterialLocalizations localizations =
                                          MaterialLocalizations.of(context);
                                      String formattedTime = localizations
                                          .formatTimeOfDay(pickedTime,
                                              alwaysUse24HourFormat: false);

                                      timeController.text =
                                          formattedTime.toString();
                                      // String formattedtime = DateFormat('hh:mm a')
                                      //     .format(pickedTime);
                                      // timeController.text =
                                      //     formattedtime.toString();
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.access_time,
                                  color: greylite,
                                ))),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      // Text(
                      //   'Popular locations in your city',
                      //   style: TextStyle(
                      //       color: tab,
                      //       fontFamily: 'NunitoSans',
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w400),
                      // )
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
                        if (formkey.currentState!.validate()) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddPage_02()));
                        } else {}
                      },
                      child: const Text(
                        'Next',
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
          ),
        ));
  }
}
