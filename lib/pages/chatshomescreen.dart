import 'package:chatting_app_1/models/chatcard.dart';
import 'package:chatting_app_1/pages/callspage.dart';
import 'package:chatting_app_1/pages/profilepage.dart';
import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatHomeScreenPage extends StatefulWidget {
  const ChatHomeScreenPage({super.key});

  @override
  State<ChatHomeScreenPage> createState() => _ChatHomeScreenPageState();
}

class _ChatHomeScreenPageState extends State<ChatHomeScreenPage> {
  int myindex = 1;

  List<Widget> widgetList = const [
    ChatHomeScreenPage(),
    CallsPage(),
    ProfilePage(),
    // Text("Calls", style: TextStyle(fontSize: 40),),
    // Text("Chats", style: TextStyle(fontSize: 40),),
    // Text("Profile", style: TextStyle(fontSize: 40),),
  ];

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(top: 15),
        //   child: FloatingActionButton(
        //     elevation: 5,
        //     backgroundColor: Vx.black,
        //     splashColor: Vx.gray600,
        //     shape:
        //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        //     onPressed: () {
        //       Future.delayed(Duration(milliseconds: 300));
        //       Navigator.pushNamed(context, MyRoutes.notificationRoute);
        //     },
        //     child: Icon(
        //       Icons.notifications_active_rounded,
        //       color: Vx.white,
        //       size: 30,
        //     ),
        //   ),
        // ),
        backgroundColor: Mycolors.backgroundcolor,
        body: Column(
          children: [
            // Center(child: widgetList[myindex]),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 25, left: 10),
              //color: Vx.red500,
              //margin: EdgeInsets.all(2),
              child: "Welcome,"
                  .text
                  .xl2
                  .light
                  .color(Mycolors.textcolorwhite)
                  .fontFamily("Poppins")
                  .make(),
            ),
            Container(
              //margin: EdgeInsets.all(0.5),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                left: 10,
              ),
              //color: Vx.green500,
              //margin: EdgeInsets.all(2),
              child: "Username"
                  .text
                  .xl3
                  .bold
                  .color(Mycolors.textcolorwhite)
                  .fontFamily("Poppins")
                  .make(),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              //width: MediaQuery.of(context).size.width,
              child: Container(

                  // color: Vx.red500,
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 26,
                  ),
                  //color: Vx.red500,
                  //width: MediaQuery.of(context).size.width/4,
                  alignment: Alignment.center,
                  child: "Chats"
                      .text
                      .xl5
                      .fontWeight(FontWeight.w400)
                      .color(Mycolors.textcolorwhite)
                      .make()),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10,right: 3,left: 3),
                  decoration: BoxDecoration(
                      color: Vx.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ChatCard();
                    },
                    itemCount: 10,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
