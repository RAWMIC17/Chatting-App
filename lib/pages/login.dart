import 'package:chatting_app_1/pages/page_login.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "lib/images/START.png",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 450, right: 165),
                  child: Image.asset("lib/images/image-7.png"),
                ),
                SizedBox(
                  height: 13,
                ),
                Container(
                  padding: EdgeInsets.only(right: 80),
                  child: Image.asset("lib/images/RnPSoft.png"),
                ),
                SizedBox(
                  height: 23,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: "Endless Possibilities."
                      .text
                      .fontWeight(FontWeight.w300)
                      .xl3
                      .fontFamily("Poppins")
                      .color(Mycolors.textcolorblue)
                      .make(),
                ),
                Container(
                  padding: EdgeInsets.only(right: 145),
                  child: "Infinite."
                      .text
                      .xl3
                      .fontWeight(FontWeight.w300)
                      .fontFamily("Poppins")
                      .color(Mycolors.textcolorblue)
                      .make(),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 320,
              padding: EdgeInsets.only(top: 680, bottom: 5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login_Page(),
                      ));
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Mycolors.buttoncolor),
                  minimumSize: MaterialStateProperty.all<Size>(Size(100, 55)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 55, right: 7),
                      child: Icon(
                        CupertinoIcons.square_arrow_right_fill,
                        color: Vx.black,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      child: " Get Started"
                          .text
                          .bold
                          .wide
                          .xl2
                          .fontFamily('Poppins')
                          .color(Vx.black)
                          .make(),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
