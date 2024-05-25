import 'package:chatting_app_1/models/callcard.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CallsPage extends StatefulWidget {
  const CallsPage({super.key});

  @override
  State<CallsPage> createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
  int myindex = 1;

  @override
  Widget build(BuildContext context) {
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
        //       size: 30,k
        //     ),
        //   ),
        // ),
        backgroundColor: Mycolors.backgroundcolor,
        body: Column(
          children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 26,
                    ),
                    //color: Vx.red500,
                    width: 310,
                    alignment: Alignment.center,
                    child: "Calls"
                        .text
                        .xl5.fontFamily("Poppins")
                        .fontWeight(FontWeight.w400)
                        .color(Mycolors.textcolorwhite)
                        .make()),
                // Container(
                //   padding: EdgeInsets.only(bottom: 8),
                //   child: TextButton(
                //       onPressed: () {
                //         Navigator.pushNamed(context, MyRoutes.groupsRoute);
                //       },
                //       child: Icon(
                //         CupertinoIcons.right_chevron,
                //         color: Vx.white,
                //         size: 30,
                //       )),
                // )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10, right: 3, left: 3),
                decoration: BoxDecoration(
                    color: Vx.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Callcard();
                  },
                  itemCount: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//bloc
//provider
//riverpod