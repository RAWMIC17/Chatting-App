import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.black,
      appBar: AppBar(
        backgroundColor: Vx.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.bottomnavigationbarRoute);
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: Vx.white,
            )),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              backgroundColor: Vx.purple600,
              radius: 22,
              child: CircleAvatar(
                foregroundImage: AssetImage("lib/images/Tony_Stark.jpg"),
                radius: 20,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            "Changu gupta"
                .text
                .fontFamily("Poppins")
                .color(Mycolors.textcolorwhite)
                .size(19)
                .make(),
          ],
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: 8),
              onPressed: () {},
              icon: Icon(
                Icons.phone,
                color: Vx.green400,
                size: 28,
              ))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Vx.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          ))
        ],
      )),
    );
  }
}
