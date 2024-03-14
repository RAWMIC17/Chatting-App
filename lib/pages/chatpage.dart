import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int myindex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 50,
          selectedItemColor: Vx.black,
          unselectedItemColor: Vx.gray500,
          iconSize: 26,
          currentIndex: myindex,
          onTap: (index) {
            setState(() {
              myindex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              //activeIcon: ,
              icon: Icon(
                Icons.phone_in_talk_rounded,
              ),
              label: 'Calls',
              //backgroundColor: Colors.green
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.chat_bubble_2_fill,
              ),
              label: 'Messages',
              //backgroundColor: Colors.yellow
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person_alt,
              ),
              label: 'Profile',
              //backgroundColor: Colors.blue,
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: FloatingActionButton(
            elevation: 5,
            backgroundColor: Vx.black,
            splashColor: Vx.gray600,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              Future.delayed(Duration(milliseconds: 300));
              Navigator.pushNamed(context, MyRoutes.notificationRoute);
            },
            child: Icon(
              Icons.notifications_active_rounded,
              color: Vx.white,
              size: 30,
            ),
          ),
        ),
        backgroundColor: Mycolors.backgroundcolor,
        body: Column(
          children: [
            Container(
              width: 385,
              padding: EdgeInsets.only(top: 25, right: 30, left: 5),
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
              width: 395,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 15, bottom: 26, left: 70),
                    //color: Vx.red500,
                    width: 310,
                    alignment: Alignment.center,
                    child: "Chats"
                        .text
                        .xl5
                        .fontWeight(FontWeight.w400)
                        .color(Mycolors.textcolorwhite)
                        .make()),
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.groupsRoute);
                      },
                      child: Icon(
                        CupertinoIcons.right_chevron,
                        color: Vx.white,
                        size: 30,
                      )),
                )
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Vx.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
