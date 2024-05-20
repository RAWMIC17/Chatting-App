import 'dart:io';

import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool _passwordvisible = false;
  final _formkey = GlobalKey<FormState>();
  bool changebutton = false;

  File? image;

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final imagePermanentPath = "${directory.path}/$name";

    // Check if the image file already exists in the permanent directory
    if (await File(imagePermanentPath).exists()) {
      // File already exists, return the file path
      return File(imagePermanentPath);
    }

    // Copy the image file to the permanent directory
    return File(imagePath).copy(imagePermanentPath);
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() {
        this.image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print('Error selecting image: $e');
    }
  }
  // var snackBar = SnackBar(content:
  // Text('Saved successfully!!',
  // style: TextStyle(fontSize: 18),
  // ),
  // duration: Duration(milliseconds: 900),
  // );

  @override
  movetoprofile(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        changebutton = true;
      });
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.profilepageRoute);
      setState(() {
        changebutton = false;
      });
    }
  }

  void _toggle() {
    setState(() {
      _passwordvisible = !_passwordvisible;
    });
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
        backgroundColor: Mycolors.backgroundcolor,
        appBar: AppBar(
          backgroundColor: Mycolors.appbarcolor,
          foregroundColor: Vx.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.profilepageRoute);
            },
            icon: Icon(CupertinoIcons.left_chevron),
          ),
          title: Container(
              child: "Edit Profile"
                  .text
                  .fontWeight(FontWeight.w300)
                  .fontFamily("Poppins")
                  .make()),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20),
              //color: Vx.red500,
              width: MediaQuery.of(context).size.width,
              child: CircleAvatar(
                backgroundColor: Vx.purple500,
                radius: 56,
                child: CircleAvatar(
                  //foregroundColor: Vx.white,
                  radius: 53,
                  backgroundImage: AssetImage(
                    "lib/images/Tony_Stark.jpg",
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.transparent),
                    splashFactory: NoSplash.splashFactory),
                child: Container(
                  height: 48,
                  //color: Colors.red,
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 8),
                  alignment: Alignment.topCenter,
                  child: ListTile(
                    splashColor: Colors.transparent,
                    horizontalTitleGap: 5,
                    //titleAlignment: ListTileTitleAlignment.center,
                    //contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8),
                    leading: Icon(
                      Icons.mode_edit_outlined,
                      color: Mycolors.purplecolor,
                      size: 27,
                    ),
                    title: "Change Image"
                        .text
                        .color(Vx.white)
                        .xl2
                        .fontFamily("Poppins")
                        .make(),
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            Container(
                //color: Colors.red,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: "Username"
                    .text
                    .fontFamily("Poppins")
                    .fontWeight(FontWeight.w300)
                    .xl
                    .color(Vx.white)
                    .make()),
            SizedBox(
              height: 50,
              child: Container(
                // height: 50,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Poppins",
                      color: Vx.black,
                      fontWeight: FontWeight.bold),
                  cursorColor: Vx.black,
                  decoration: InputDecoration(
                    //isCollapsed: true,
                    prefixIcon: Container(
                      padding: EdgeInsets.only(left: 2),
                      child: Icon(
                        CupertinoIcons.person_crop_square,
                        size: 28,
                        color: Vx.black,
                      ),
                    ),
                    hintText: "Username",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontFamily: "Poppins",
                        fontSize: 15,
                        color: Vx.black),
                    isDense: true,
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Vx.white,
                    filled: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
                //color: Colors.red,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: "Email"
                    .text
                    .fontFamily("Poppins")
                    .fontWeight(FontWeight.w300)
                    .xl
                    .color(Vx.white)
                    .make()),
            SizedBox(
              height: 50,
              child: Container(
                // height: 50,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Poppins",
                      color: Vx.black,
                      fontWeight: FontWeight.bold),
                  cursorColor: Vx.black,
                  decoration: InputDecoration(
                    //isCollapsed: true,
                    prefixIcon: Container(
                      padding: EdgeInsets.only(left: 2),
                      child: Icon(
                        CupertinoIcons.mail,
                        size: 28,
                        color: Vx.black,
                      ),
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontFamily: "Poppins",
                        fontSize: 15,
                        color: Vx.black),
                    isDense: true,
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Vx.white,
                    filled: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
                //color: Colors.red,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: "Phone No."
                    .text
                    .fontFamily("Poppins")
                    .fontWeight(FontWeight.w300)
                    .xl
                    .color(Vx.white)
                    .make()),
            SizedBox(
              height: 50,
              child: Container(
                // height: 50,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Poppins",
                      color: Vx.black,
                      fontWeight: FontWeight.bold),
                  cursorColor: Vx.black,
                  decoration: InputDecoration(
                    //isCollapsed: true,
                    prefixIcon: Container(
                      padding: EdgeInsets.only(left: 2),
                      child: Icon(
                        CupertinoIcons.phone,
                        size: 28,
                        color: Vx.black,
                      ),
                    ),
                    hintText: "Phone",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontFamily: "Poppins",
                        fontSize: 15,
                        color: Vx.black),
                    isDense: true,
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Vx.white,
                    filled: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
                //color: Colors.red,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: "Password"
                    .text
                    .fontFamily("Poppins")
                    .fontWeight(FontWeight.w300)
                    .xl
                    .color(Vx.white)
                    .make()),
            Container(
              height: 67,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                //selectionHeightStyle: ,
                obscureText: !_passwordvisible,
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: "Poppins",
                    color: Vx.black,
                    fontWeight: FontWeight.bold),
                cursorColor: Vx.black,
                decoration: InputDecoration(
                    //isCollapsed: true,
                    prefixIcon: Container(
                      padding: EdgeInsets.only(left: 2),
                      child: Icon(
                        Icons.lock_outline,
                        size: 28,
                        color: Vx.black,
                      ),
                    ),
                    hintText: "Enter New Password",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontFamily: "Poppins",
                        fontSize: 15,
                        color: Vx.black),
                    isDense: true,
                    //contentPadding: EdgeInsets.all(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Vx.white,
                    filled: true,
                    suffix: IconButton(
                      onPressed: () {
                        _toggle();
                      },
                      //highlightColor: Vx.black,
                      icon: Icon(
                          _passwordvisible
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                          size: 23,
                          color: Vx.black),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password can't be empty";
                  } else if (value.length < 8) {
                    return "Password must be atleast 8 alphanumeric code";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.all(20),
              //height: MediaQuery.of(context).size.width,
              //color: Colors.red,
              child: SizedBox(
                width: 270,
                height: 45,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust the radius as needed
                          ),
                        ),
                        backgroundColor: changebutton
                            ? MaterialStatePropertyAll(Vx.green600)
                            : MaterialStatePropertyAll(Vx.purple600)),
                    onPressed: () {
                      movetoprofile(context);
                    },
                    child: changebutton
                        ? "Saved"
                            .text
                            .xl
                            .color(Vx.white)
                            .fontFamily("Poppins")
                            .make()
                        : "Save Changes"
                            .text
                            .xl
                            .color(Vx.white)
                            .fontFamily("Poppins")
                            .make()),
              ),
            )
          ],
        )),
      ),
    );
  }
}
