import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:footyaddicts/api/api.dart';
import 'package:footyaddicts/constant/color.dart';
import 'package:footyaddicts/forgot.dart/otp.dart';
import 'package:footyaddicts/models/Editprofile.dart';
import 'package:footyaddicts/profile.dart';
import 'package:footyaddicts/services/Services.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditScreen extends StatefulWidget {
  EditScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  List ListItems = ['Male', 'Female', 'Others'];
  String? Choose;
  String? _gender;
  late String _name, _email, _phone, _username, _about;

  TextEditingController date = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool _isLoading = true;
  final TextEditingController fullname = new TextEditingController();
  final TextEditingController username = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController about = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date.text = '';
    edit();

    // timeofDay = TimeOfDay.now();
  }

  File? image;

  XFile? _pickedFile;
  CroppedFile? _croppedFile;
  String? _fullname;

  // late List<EditProfile> users = [];
  // edit() async {
  //   Services.edit().then((results) {
  //     setState(() {
  //       email.text = results[0].email;
  //       fullname.text = results[0].fullName;
  //       username.text = results[0].userName;
  //       mobile.text = results[0].mobile;
  //  print(response.body);
  //   print(response.statusCode);
  //   var response_data = json.decode(response.body.toString());
  //   print(response_data);
  //   if (response.statusCode == 200) {
  //     print(response_data['user_id']);
  //     print(response_data['email']);
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => Navigation()));
  //     print('Sucessfull');
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(response_data['message']),
  //       backgroundColor: Colors.red.shade300,
  //     ));
  //     print('Error');
  //   }
  // }
  //       // print(results[0].fullName);

  //       // users = results;
  //       // _fullname = users[0].fullName;
  //       // print(users.length);
  //       // print(users[0].mobile);
  //     });
  //   });
  // }

  update_user(
      // fullname, username, mobile, gender, dob, about
      ) async {
    print("----------5");
    SharedPreferences session = await SharedPreferences.getInstance();

    var Email = session.getString('email');
    var user_id = session.getInt('user_id');

    print("----------6");
    Map data = {
      'id': user_id.toString(),
      'email': Email.toString(),
      'full_name': fullname.text,
      'user_name': username.text,
      'mobile': mobile.text,
      'gender': _gender,
      'about': about.text,
      'dob': date.text,
    };
    print("----------7");
    print(data);

    var url = Update_profile;

    // var body = json.encode(data);
    var urlparse = Uri.parse(url);

    http.Response response = await http.post(
      urlparse,
      body: data,
    );
    print(urlparse);
    var response_data = json.decode(response.body.toString());
    print(response_data);
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response_data['message'].toString()),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

  Future edit() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var Email = session.getString('email');
    var user_id = session.getInt('user_id');
    var url = Edit_profile;

    var urlparse = Uri.parse(url);
    Map data = {"id": user_id.toString()};
    print(data);
    http.Response res = await http.post(
      urlparse,
      body: data,
    );
    if (res.statusCode == 200) {
      var resBody = (json.decode(res.body.toString()));
      print(resBody['data']['full_name']);
      print(resBody);
      setState(() {
        _isLoading = true;

        fullname.text = (resBody['data']['full_name'].toString());
        username.text = (resBody['data']['user_name'].toString());
        mobile.text = (resBody['data']['mobile'].toString());
        email.text = (resBody['data']['email'].toString());
        about.text = (resBody['data']['about'].toString());
        // fullname.text = resBody['full_name'].toString();
      });

      return "Success";
    } else {
      _isLoading = false;
      print("error");
      print(res.body.toString());
    }
  }

  // Future<EditProfile> edit() async {
  //   SharedPreferences _preferences = await SharedPreferences.getInstance();
  //   // var token = _preferences.getString("token");
  //   var Email = _preferences.getString("email");
  //   Map data = {
  //     'email': email.text,
  //     // 'email': _preferences.getString("email"),
  //     'username': _preferences.getString("Username")
  //     // 'customer_id': sharedPreferences.getString("user_id"),
  //   };
  //   print(data);

  //   var url = Edit_profile;
  //   var urlparse = Uri.parse(url);

  //   final response = await http.get(urlparse);
  //   print(urlparse);

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     var userDetail = (json.decode(response.body.toString()));
  //     print(userDetail);

  //     setState(() {
  //       image = (userDetail['image']);
  //       fullname.text = (userDetail['full_name'].toString());
  //       username.text = (userDetail['user_name'].toString());
  //       mobile.text = (userDetail['mobile'].toString());
  //       email.text = (userDetail['email'].toString());
  //     });

  //     print(fullname);

  //     return EditProfile.fromJson(userDetail);
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     throw Exception('Failed to load post');
  //   }
  // }

  Future pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    cropImage(pickedFile!.path);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  Future Camera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    cropImage(pickedFile!.path);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  cropImage(filePath) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if (croppedImage != null) {
      _croppedFile = croppedImage;

      // print(_croppedFile!.path.toString());
      setState(() {
        image = File(croppedImage.path);
      });
      // Navigator.pop(context);
    }
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
            'Edit Profile',
            style: TextStyle(
              color: black,
              fontFamily: 'IBMPlexSans',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: new SizedBox(
                              width: 180.0,
                              height: 180.0,
                              child: (image != null)
                                  ? Image.file(
                                      image!,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset('assets/images/av.png'),
                              // Image.network(
                              //   "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                              //   fit: BoxFit.fill,
                              // ),
                            ),
                          ),
                        ),
                        // CircleAvatar(
                        //   foregroundColor: red,
                        //   radius: 55,
                        //   // backgroundImage:
                        //   //     image != null ? FileImage(image!) : null,
                        //   backgroundImage: AssetImage('assets/images/av.png'),
                        // ),
                        Positioned(
                          right: -1,
                          bottom: -3,
                          child: Container(
                            height: 28,
                            child: FloatingActionButton.small(
                              backgroundColor: red,
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) {
                                      return Container(
                                        height: 100,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Choose profile photo',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: red),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton.icon(
                                                    onPressed: () {
                                                      Camera();
                                                    },
                                                    icon: const Icon(Icons
                                                        .camera_alt_outlined),
                                                    label:
                                                        const Text('Camera')),
                                                ElevatedButton.icon(
                                                    onPressed: () {
                                                      pickImage();
                                                    },
                                                    icon:
                                                        const Icon(Icons.image),
                                                    label:
                                                        const Text('Gallery'))
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }));
                              },
                              child:
                                  Icon(Icons.border_color_outlined, size: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: grey,
                  thickness: 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name',
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
                        controller: fullname,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter fullname";
                          }
                          return null;
                        },
                        onSaved: (name) {
                          _name = name!;
                        },
                        // cursorColor: white,

                        style: TextStyle(
                            color: black,
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          // fillColor: light,
                          // filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 1, color: grey),
                              borderRadius: BorderRadius.circular(24)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: red, width: 2.5),
                              borderRadius: BorderRadius.circular(24)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: red, width: 2)),
                          contentPadding: const EdgeInsets.only(left: 20),
                          hintText: 'Enter Full name',
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Username',
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
                        controller: username,

                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter username";
                          }
                          return null;
                        },
                        onSaved: (username) {
                          username = username.toString();
                        },
                        // cursorColor: white,

                        style: TextStyle(
                            color: black,
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          // fillColor: light,
                          // filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 1, color: grey),
                              borderRadius: BorderRadius.circular(24)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: red, width: 2),
                              borderRadius: BorderRadius.circular(24)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: red, width: 2)),
                          contentPadding: const EdgeInsets.only(left: 20),

                          hintText: 'Enter Username',
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Phone',
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
                        controller: mobile,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter phone number";
                          }
                          if (value.length < 9) {
                            return "Please enter a valid phone number";
                          }
                          return null;
                        },
                        onSaved: (phone) {
                          _phone = phone!;
                        },
                        // cursorColor: white,

                        style: TextStyle(
                            color: black,
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          // fillColor: light,
                          // filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 1, color: grey),
                              borderRadius: BorderRadius.circular(24)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: red, width: 2),
                              borderRadius: BorderRadius.circular(24)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: red, width: 2)),
                          contentPadding: const EdgeInsets.only(left: 20),
                          hintText: 'Enter Phone Number',
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Email',
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
                        controller: email,
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter email";
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        onSaved: (email) {
                          _email = email!;
                        },
                        // cursorColor: white,

                        style: TextStyle(
                            color: black,
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            // fillColor: light,
                            // filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 1, color: grey),
                                borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: red, width: 2),
                                borderRadius: BorderRadius.circular(24)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(color: red, width: 2)),
                            contentPadding: const EdgeInsets.only(left: 20),
                            hintText: 'Enter Email',
                            hintStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal),
                            suffixIcon: Icon(
                              Icons.email_outlined,
                              color: grey,
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Gender',
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
                      Container(
                        height: 45,
                        child: DropdownButtonFormField(
                          style: TextStyle(
                              color: black,
                              fontSize: 14,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w500),
                          // value: dropdownvalue,
                          value: _gender,
                          isExpanded: true,
                          onChanged: (newValue) {
                            setState(() {
                              _gender = newValue as String;
                            });
                          },
                          items: ListItems.map((List) {
                            return DropdownMenuItem(
                                child: Text(List), value: List);
                          }).toList(),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 14, right: 20),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: grey),
                                borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: red),
                                borderRadius: BorderRadius.circular(24)),
                            // border: OutlineInputBorder(
                            //   borderRadius: const BorderRadius.all(
                            //     const Radius.circular(24),
                            // ),
                            // ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Date of Birth',
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
                        readOnly: true,
                        // keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter Date of Birth";
                          }
                          return null;
                        },
                        onSaved: (time) {
                          time = time!;
                        },
                        onTap: () async {
                          DateTime? datePicked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                          );

                          if (datePicked != null) {
                            String formattedDate =
                                DateFormat("dd-MM-yyyy").format(datePicked);
                            setState(() {
                              date.text = formattedDate.toString();
                            });
                          }
                        },
                        style: TextStyle(
                            color: black,
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        controller: date,
                        decoration: InputDecoration(
                            // fillColor: light,
                            // filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 1, color: grey),
                                borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: red, width: 2),
                                borderRadius: BorderRadius.circular(24)),
                            contentPadding: const EdgeInsets.only(left: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(color: red, width: 2)),
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
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2100),
                                  );

                                  if (datePicked != null) {
                                    String formattedDate =
                                        DateFormat("dd-MM-yyyy")
                                            .format(datePicked);
                                    setState(() {
                                      date.text = formattedDate.toString();
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
                        'About',
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
                        controller: about,

                        keyboardType: TextInputType.text,
                        // validator: (value) =>
                        //     value == null ? 'Please enter details' : null,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter details";
                          }
                          return null;
                        },
                        onSaved: (about) {
                          about = about;
                        },
                        // cursorColor: white,

                        style: TextStyle(
                            color: black,
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          // fillColor: light,
                          // filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 1, color: grey),
                              borderRadius: BorderRadius.circular(24)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: red, width: 2),
                              borderRadius: BorderRadius.circular(24)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: red, width: 2)),
                          contentPadding: const EdgeInsets.only(left: 20),
                          hintText: 'Say about Yourself',
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Maximum 30 charatcters',
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: lite),
                      ),
                      SizedBox(
                        height: 30,
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
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => ProfilePage()));
                            if (formkey.currentState!.validate()) {
                              update_user(
                                  // fullname.text, username.text,
                                  //   mobile.text, _gender, date.text, about.text
                                  );
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => ProfilePage()));
                            } else {}
                          },
                          child: const Text(
                            'Save Changes',
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
        ));
  }
}
