import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:chatting_app_1/utils/pickimage.dart';
import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

//     Uint8List _image = Uint8List(0);
//   Future<void> selectImage() async {
//   try {
//     Uint8List img = await pickImage(ImageSource.gallery);
//     setState(() {
//       _image = img;
//     });
//   } catch (e) {
//     // Handle error, e.g., show a dialog or log the error
//     print('Error selecting image: $e');
//   }
// }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Vx.black,
        appBar: AppBar(
          backgroundColor: Mycolors.appbarcolor,
          foregroundColor: Vx.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.bottomnavigationbarRoute);
            },
            icon: Icon(CupertinoIcons.left_chevron),
          ),
          title: Container(
              child: "Profile"
                  .text
                  .fontWeight(FontWeight.w300)
                  .fontFamily("Poppins")
                  .make()),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                //width: 300,
                //color: Vx.red500,
                padding: EdgeInsets.all(27),
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    image != null
                        ? CircleAvatar(
                            radius: 69,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                                radius: 66,
                                child: ClipOval(
                                    child: Image.file(
                                  image!,
                                  height: 150,
                                  width: 150,
                                ))),
                          )
                        // ? CircleAvatar(
                        //   radius: 66,
                        //   backgroundImage: MemoryImage(image! as Uint8List),
                        // )
                        : CircleAvatar(
                            backgroundColor: Vx.white,
                            radius: 69,
                            child: CircleAvatar(
                              //foregroundColor: Vx.white,
                              radius: 66,
                              backgroundImage: AssetImage(
                                "lib/images/Tony_Stark.jpg",
                              ),
                            ),
                          ),
                    Positioned(
                      top: 90,
                      left: 86,
                      child: ElevatedButton(
                        onPressed: () {
                          pickImage();
                          //int  count = 0;
                          //print("Pressed");
                        },
                        style: ButtonStyle(
                            iconSize: MaterialStatePropertyAll(22),
                            padding: MaterialStatePropertyAll(
                                const EdgeInsets.only(right: 0)),
                            elevation: MaterialStatePropertyAll(15),
                            backgroundColor:
                                MaterialStatePropertyAll(Vx.purple500),
                            iconColor: MaterialStatePropertyAll(Vx.white),
                            shape: MaterialStateProperty.all(CircleBorder())),
                        child: Icon(Icons.mode_edit_outlined),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: "UserName"
                      .text
                      .xl4
                      .bold
                      .fontFamily("Poppins")
                      .color(Mycolors.textcolorwhite)
                      .make(),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: "name@email.com"
                      .text
                      .caption(context)
                      .xl
                      .fontWeight(FontWeight.w300)
                      .size(16)
                      .wide
                      .color(Vx.gray400)
                      .make(),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                width: 220,
                height: 52,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.editpageRoute);
                    },
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                      backgroundColor: MaterialStatePropertyAll(Vx.gray500),
                      foregroundColor:
                          MaterialStatePropertyAll(Mycolors.textcolorwhite),
                      elevation: MaterialStatePropertyAll(15),
                    ),
                    child: "Edit Profile"
                        .text
                        .xl
                        .fontWeight(FontWeight.w300)
                        .color(Vx.gray300)
                        .fontFamily("Poppins")
                        .make()),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 15,
                ),
                width: 345,
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Mycolors.appbarcolor),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 12),
                      //color: Vx.red500,
                      child: Icon(
                        CupertinoIcons.doc_person_fill,
                        color: Vx.white,
                        size: 31,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 6, top: 5),
                      child: "Skills"
                          .text
                          .fontFamily("Poppins")
                          .xl2
                          .fontWeight(FontWeight.w300)
                          .color(Mycolors.textcolorwhite)
                          .make(),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 175),
                      height: 33,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, MyRoutes.skillspageRoute);
                        },
                        child: Icon(
                          CupertinoIcons.right_chevron,
                        ),
                        style: ButtonStyle(
                            //alignment: Alignment.centerRight,
                            elevation: MaterialStatePropertyAll(15),
                            shape: MaterialStateProperty.all(CircleBorder()),
                            backgroundColor:
                                MaterialStatePropertyAll(Mycolors.appbarcolor),
                            iconColor: MaterialStatePropertyAll(Vx.gray300),
                            iconSize: MaterialStatePropertyAll(17)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 15,
                ),
                width: 345,
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Mycolors.appbarcolor),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 12),
                      //color: Vx.red500,
                      child: Icon(
                        Icons.thumbs_up_down_rounded,
                        color: Vx.white,
                        size: 31,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 6, top: 5),
                      child: "Reviews"
                          .text
                          .fontFamily("Poppins")
                          .xl2
                          .fontWeight(FontWeight.w300)
                          .color(Mycolors.textcolorwhite)
                          .make(),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 142),
                      height: 33,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          CupertinoIcons.right_chevron,
                        ),
                        style: ButtonStyle(
                            //alignment: Alignment.centerRight,
                            elevation: MaterialStatePropertyAll(15),
                            shape: MaterialStateProperty.all(CircleBorder()),
                            backgroundColor:
                                MaterialStatePropertyAll(Mycolors.appbarcolor),
                            iconColor: MaterialStatePropertyAll(Vx.gray300),
                            iconSize: MaterialStatePropertyAll(17)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 15,
                ),
                width: 345,
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Mycolors.appbarcolor),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 12),
                      //color: Vx.red500,
                      child: Icon(
                        CupertinoIcons.settings_solid,
                        color: Vx.white,
                        size: 31,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 6, top: 5),
                      child: "Settings"
                          .text
                          .fontFamily("Poppins")
                          .xl2
                          .fontWeight(FontWeight.w300)
                          .color(Mycolors.textcolorwhite)
                          .make(),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 141),
                      height: 33,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          CupertinoIcons.right_chevron,
                        ),
                        style: ButtonStyle(
                            //alignment: Alignment.centerRight,
                            elevation: MaterialStatePropertyAll(15),
                            shape: MaterialStateProperty.all(CircleBorder()),
                            backgroundColor:
                                MaterialStatePropertyAll(Mycolors.appbarcolor),
                            iconColor: MaterialStatePropertyAll(Vx.gray300),
                            iconSize: MaterialStatePropertyAll(17)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 15,
                ),
                width: 345,
                height: 49,
                // decoration: BoxDecoration(
                //   border: Border(
                //     bottom: BorderSide(width: 1, color: Mycolors.appbarcolor),
                //   ),
                // ),
                child: InkWell(
                  onTap: () async {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: "Logged Out Successfully".text.make(),
                      duration: Duration(milliseconds: 1200),
                    ));
                    await Future.delayed(Duration(milliseconds: 500));
                    await Navigator.pushNamedAndRemoveUntil(context,
                        MyRoutes.loginRoute, (Route<dynamic> route) => false);
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 12),
                        //color: Vx.red500,
                        child: Icon(
                          Icons.power_settings_new_rounded,
                          color: Vx.white,
                          size: 31,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 6, top: 5),
                        child: "Logout"
                            .text
                            .fontFamily("Poppins")
                            .xl2
                            .fontWeight(FontWeight.w300)
                            .color(Mycolors.textcolorwhite)
                            .make(),
                      ),
                      // Container(
                      //   padding: EdgeInsets.only(left: 141),
                      //   height: 33,
                      //   child: ElevatedButton(
                      //     onPressed: () {},
                      //     child: Icon(
                      //       CupertinoIcons.right_chevron,
                      //     ),
                      //     style: ButtonStyle(
                      //         //alignment: Alignment.centerRight,
                      //         elevation: MaterialStatePropertyAll(15),
                      //         shape: MaterialStateProperty.all(CircleBorder()),
                      //         backgroundColor:
                      //             MaterialStatePropertyAll(Mycolors.appbarcolor),
                      //         iconColor: MaterialStatePropertyAll(Vx.gray300),
                      //         iconSize: MaterialStatePropertyAll(17)),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                //color: Vx.red500,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: "Joined on dd/mm/yyyy"
                    .text
                    .lg
                    .fontWeight(FontWeight.w300)
                    .fontFamily("Poppins")
                    .color(Mycolors.textcolorwhite)
                    .make(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
