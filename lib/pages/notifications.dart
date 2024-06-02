import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int myindex = 1;
  bool ispressed = false;

  void clearall() {
    setState(() {
      ispressed = !ispressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.black,
      // bottomNavigationBar: BottomNavigationBar(
      //   elevation: 50,
      //   selectedItemColor: Vx.black,
      //   unselectedItemColor: Vx.gray500,
      //   iconSize: 26,
      //   currentIndex: myindex,
      //   onTap: (index) {
      //     setState(() {
      //       myindex = index;
      //     });
      //   },
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       //activeIcon: ,
      //       icon: Icon(
      //         Icons.phone_in_talk_rounded,
      //       ),
      //       label: 'Calls',
      //       //backgroundColor: Colors.green
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         CupertinoIcons.chat_bubble_2_fill,
      //       ),
      //       label: 'Messages',
      //       //backgroundColor: Colors.yellow
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         CupertinoIcons.person_alt,
      //       ),
      //       label: 'Profile',
      //       //backgroundColor: Colors.blue,
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, MyRoutes.bottomnavigationbarRoute);
                      },
                      child: Icon(
                        CupertinoIcons.chevron_left,
                        color: Vx.white,
                        size: 30,
                      )),
                ),
                Container(
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 26,
                    ),
                    //color: Vx.red500,
                    //width: MediaQuery.of(context).size.width/1 ,
                    //alignment: Alignment.center,
                    child: "Notifications"
                        .text
                        .xl5
                        .fontWeight(FontWeight.w400)
                        .color(Mycolors.textcolorwhite)
                        .make()),
                Container(
                  //width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(bottom: 10, right: 15),
                  child: Icon(
                    Icons.notifications_active_rounded,
                    color: Vx.white,
                    size: 25,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              child: "System Notifications".text.xl2.make()),
                          Container(
                            height: 30,
                            width: 112,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  clearall();
                                });
                              },
                              child: ispressed? "Clear All".text.size(13).make():Row(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.check,color: Vx.white,size: 18,),
                                  "Cleared".text.size(13).make(),
                                ],
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Vx.purple500),
                                  foregroundColor: MaterialStatePropertyAll(
                                      Mycolors.textcolorwhite),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Vx.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
