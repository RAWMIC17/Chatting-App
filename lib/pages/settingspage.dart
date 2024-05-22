import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _launchUrl(Uri uri, bool inApp) async {
    try {
      if (await canLaunchUrl(uri)) {
        if (inApp) {
          await launchUrl(
            uri,
            mode: LaunchMode.inAppWebView,
          );
        } else {
          await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
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
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.profilepageRoute);
            },
            icon: Icon(CupertinoIcons.left_chevron),
          ),
          title: Container(
              child: "Settings"
                  .text
                  .fontWeight(FontWeight.w300)
                  .fontFamily("Poppins")
                  .make()),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 1.9,
            ),
            TextButton(
              style: ButtonStyle(splashFactory: NoSplash.splashFactory),
              onPressed: () {
                //print("Delete pressed");
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: Mycolors.appbarcolor,
                          scrollable: true,
                          title: Center(
                              child: Text(
                            "Delete Account",
                          )),
                          titleTextStyle: TextStyle(
                              color: Mycolors.textcolorwhite,
                              fontFamily: "Poppins",
                              fontSize: 28),
                          content: Text(
                              "Do you really want to delete your account?"),
                          contentTextStyle: TextStyle(
                            color: Mycolors.textcolorwhite,
                            fontSize: 15,
                            letterSpacing: 1,
                            fontFamily: "Poppins",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                //Delete Account fucntions goes here
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Mycolors.textcolorwhite,
                                    fontSize: 18),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "No",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Mycolors.textcolorwhite,
                                    fontSize: 18),
                              ),
                            )
                          ],
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                          //titlePadding: EdgeInsets.symmetric(horizontal: 20),
                          //contentPadding: EdgeInsets.symmetric(horizontal: -20),
                        ));
              }, //Function to delete account goes here
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 15),
                padding: EdgeInsets.only(bottom: 22),
                //color: Vx.red500,
                decoration: BoxDecoration(
                    //color: Vx.red500,
                    border: Border(
                        bottom: BorderSide(color: Vx.white, width: 0.2))),
                child: "Delete Account"
                    .text
                    .fontFamily("Poppins")
                    .xl2
                    .fontWeight(FontWeight.w300)
                    .color(Mycolors.textcolorwhite)
                    .make(),
              ),
            ),
            TextButton(
              style: ButtonStyle(splashFactory: NoSplash.splashFactory),
              onPressed: () {
                _launchUrl(Uri.parse("https://rnpsoft.framer.website/"), true);
                print("pressed");
              }, //About company page link goes here
              child: Container(
                padding: EdgeInsets.only(bottom: 18),
                margin: EdgeInsets.only(left: 15, top: 13),
                //color: Vx.red500,
                decoration: BoxDecoration(
                    //color: Vx.red500,
                    border: Border(
                        bottom: BorderSide(color: Vx.white, width: 0.2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      //margin: EdgeInsets.only(left: 15),
                      child: "About RnPSoft"
                          .text
                          .fontFamily("Poppins")
                          .xl2
                          .fontWeight(FontWeight.w300)
                          .color(Mycolors.textcolorwhite)
                          .make(),
                    ),
                    Container(
                      child: Image.asset(
                        "lib/images/image-7.png",
                        scale: 1.8,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                //padding: EdgeInsets.only(top: 20),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 1.25),
                // height: MediaQuery.of(context).size.width/2,
                //color: Colors.red,
                child: "© 2024 RnPSoft All Rights Reserved"
                    .text
                    .color(Mycolors.textcolorwhite)
                    .fontFamily("Poppins")
                    .xs
                    .make())
          ],
        ),
      ),
    );
  }
}
