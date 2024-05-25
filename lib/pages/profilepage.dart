import 'dart:io';
import 'package:chatting_app_1/pages/editprofile.dart';
import 'package:chatting_app_1/pages/reviewspage.dart';
import 'package:chatting_app_1/pages/settingspage.dart';
import 'package:chatting_app_1/pages/skillspage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatting_app_1/services/auth/auth_service.dart';
import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  AuthService _authService = AuthService();
  final FirebaseFirestore _firestore;

  ProfilePage({Key? key, required FirebaseFirestore firestore})
      : _firestore = firestore,
        super(key: key);

  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  String? _profileImageUrl;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      String fileName = path.basename(pickedImage.path);
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(fileName);
      firebase_storage.UploadTask uploadTask =
          ref.putFile(File(pickedImage.path));

      uploadTask.then((res) {
        res.ref.getDownloadURL().then((downloadURL) {
          _updateProfilePicture(downloadURL);
        });
      });

      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  void _updateProfilePicture(String downloadURL) {
    var user = widget._authService.getCurrentUser();
    if (user != null) {
      widget._firestore.collection("Users").doc(user.uid).update({
        "profileImage": downloadURL,
      }).then((value) {
        setState(() {
          _profileImageUrl = downloadURL;
        });
      }).catchError((error) {
        print("Error updating profile picture: $error");
      });
    }
  }

  void _fetchProfileImageUrl() {
    var user = widget._authService.getCurrentUser();
    if (user != null) {
      widget._firestore
          .collection("Users")
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          setState(() {
            _profileImageUrl = (documentSnapshot.data()
                as Map<String, dynamic>?)?["profileImage"];
          });
        }
      }).catchError((error) {
        print("Error fetching profile image URL: $error");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProfileImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Vx.black,
        appBar: AppBar(
          backgroundColor: Mycolors.appbarcolor,
          foregroundColor: Vx.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, MyRoutes.bottomnavigationbarRoute);
          //   },
          //   icon: Icon(CupertinoIcons.left_chevron),
          // ),
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
                padding: EdgeInsets.all(27),
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Vx.white,
                      radius: 70,
                      child: CircleAvatar(
                        radius: 67,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : _profileImageUrl != null
                                ? NetworkImage(_profileImageUrl!)
                                : AssetImage("lib/images/blank_dp.png")
                                    as ImageProvider,
                      ),
                    ),
                    Positioned(
                      top: 94,
                      left: 82,
                      child: ElevatedButton(
                        onPressed: _pickImage,
                        style: ButtonStyle(
                          iconSize: WidgetStatePropertyAll(20),
                          iconColor: WidgetStatePropertyAll(Vx.white),
                          backgroundColor: MaterialStatePropertyAll(Mycolors.purplecolor),
                          shape: MaterialStateProperty.all(CircleBorder()),
                        ),
                        child: Icon(Icons.mode_edit_outlined),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 14),
              Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: AuthService()
                      .getCurrentUser()
                      ?.email
                      .toString()
                      .text
                      .xl3
                      .color(Mycolors.textcolorwhite)
                      .fontFamily("Poppins")
                      .make(),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                width: 220,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPage(),
                        ));
                  },
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                    backgroundColor: WidgetStateProperty.all(Vx.gray500),
                    foregroundColor:
                        WidgetStateProperty.all(Mycolors.textcolorwhite),
                    elevation: WidgetStateProperty.all(15),
                  ),
                  child: "Edit Profile"
                      .text
                      .xl
                      .fontWeight(FontWeight.w300)
                      .color(Vx.gray300)
                      .fontFamily("Poppins")
                      .make(),
                ),
              ),
              SizedBox(height: 50),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SkillsPage(),
                              ));
                        },
                        child: Icon(
                          CupertinoIcons.right_chevron,
                        ),
                        style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(15),
                            shape: WidgetStatePropertyAll(CircleBorder()),
                            backgroundColor:
                                WidgetStatePropertyAll(Mycolors.appbarcolor),
                            iconColor: WidgetStatePropertyAll(Vx.gray300),
                            iconSize: WidgetStatePropertyAll(17)),
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewsPage(),
                              ));
                        },
                        child: Icon(
                          CupertinoIcons.right_chevron,
                        ),
                        style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(15),
                            shape: WidgetStatePropertyAll(CircleBorder()),
                            backgroundColor:
                                WidgetStatePropertyAll(Mycolors.appbarcolor),
                            iconColor: WidgetStatePropertyAll(Vx.gray300),
                            iconSize: WidgetStatePropertyAll(17)),
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsPage(),
                              ));
                        },
                        child: Icon(
                          CupertinoIcons.right_chevron,
                        ),
                        style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(15),
                            shape: WidgetStatePropertyAll(CircleBorder()),
                            backgroundColor:
                                WidgetStatePropertyAll(Mycolors.appbarcolor),
                            iconColor: WidgetStatePropertyAll(Vx.gray300),
                            iconSize: WidgetStatePropertyAll(17)),
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
                  onTap: widget.logout,
                  // () async {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: "Logged Out Successfully".text.make(),
                  //     duration: Duration(milliseconds: 1200),
                  //   ));
                  //   await widget.logout;
                  //   // await Future.delayed(Duration(milliseconds: 500));
                  //   // await Navigator.pushNamedAndRemoveUntil(context,
                  //   //     MyRoutes.loginRoute, (Route<dynamic> route) => false);
                  // },
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
