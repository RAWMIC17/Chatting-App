import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 2,
            ),
            TextButton(
              style: ButtonStyle(splashFactory: NoSplash.splashFactory),
              onPressed: () {}, //Function to delete account goes here
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 15),
                padding: EdgeInsets.only(bottom: 20),
                //color: Vx.red500,
                decoration: BoxDecoration(
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
                padding: EdgeInsets.only(bottom: 15),
                margin: EdgeInsets.only(left: 15, top: 13),
                //color: Vx.red500,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Vx.white, width: 0.2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      //margin: EdgeInsets.only(left: 15),
                      child: "About RnpSoft"
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
            TextButton(
              style: ButtonStyle(splashFactory: NoSplash.splashFactory),
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: "Logged Out Successfully".text.make(),
                  duration: Duration(milliseconds: 1200),
                ));
                await Future.delayed(Duration(milliseconds: 500));
                await Navigator.pushNamedAndRemoveUntil(context,
                    MyRoutes.loginRoute, (Route<dynamic> route) => false);
              },
              child: Container(
                margin: EdgeInsets.only(top: 15, left: 5),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 13),
                      //color: Vx.red500,
                      child: Icon(
                        Icons.power_settings_new_rounded,
                        color: Vx.white,
                        size: 31,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: "Logout"
                          .text
                          .fontFamily("Poppins")
                          .xl2
                          .fontWeight(FontWeight.w300)
                          .color(Mycolors.textcolorwhite)
                          .make(),
                    ),
                  ],
                ),
              ),
            ),
            //SizedBox(height: MediaQuery.of(context).size.width/2,),
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 1.5),
                // height: MediaQuery.of(context).size.width/2,
                //color: Colors.red,
                child: "© 2024 RnpSoft All Rights Reserved"
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
