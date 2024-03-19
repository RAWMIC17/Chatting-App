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
          ),
        ],
      )),
    );
  }
}
