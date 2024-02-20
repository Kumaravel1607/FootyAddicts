import 'package:flutter/material.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  // DateTime date = DateTime(20, 12, 2000);
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Container(
            height: 45,
            child: TextField(
              controller: dateController,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(left: 20, top: 14, right: 20),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: grey),
                      borderRadius: BorderRadius.circular(24)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: grey),
                      borderRadius: BorderRadius.circular(24)),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(24),
                    ),
                  ),
                  labelText: "Enter Date",
                  // labelText: '${date.day}-${date.month}-${date.year}',
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
                              DateFormat("dd-MM-yyyy").format(datePicked);
                          setState(() {
                            dateController.text = formattedDate.toString();
                          });
                        }
                        // print(
                        //     'Date Selected: ${datePicked.day}-${datePicked.month}-${datePicked.year}');
                      },
                      icon: Icon(Icons.calendar_today))),
            ),
          ),
        ),
      ),
    );
  }
}
