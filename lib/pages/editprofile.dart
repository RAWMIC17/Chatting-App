import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.transparent),
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
                    color: Vx.purple500,
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
          SizedBox(
            height: 50,
            child: Container(
              // height: 50,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
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
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Vx.white,
                    filled: true,
                    suffixIcon: Icon(
                      CupertinoIcons.eye_slash,
                      size: 23,
                      color: Vx.black,
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10),
            margin: EdgeInsets.all(22),
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
                      backgroundColor: MaterialStatePropertyAll(Vx.purple600)),
                  onPressed: () {},
                  child: "Save Changes"
                      .text
                      .xl
                      .color(Vx.white)
                      .fontFamily("Poppins")
                      .make()),
            ),
          )
        ],
      )),
    );
  }
}
