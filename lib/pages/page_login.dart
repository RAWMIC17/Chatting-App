import 'package:chatting_app_1/services/auth/auth_service.dart';
import 'package:chatting_app_1/models/custom_text.dart';
import 'package:chatting_app_1/models/my_button.dart';
import 'package:chatting_app_1/models/my_textfield.dart';
import 'package:chatting_app_1/pages/register_page.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class Login_Page extends StatelessWidget {
  // email and password controllers
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _pwcontroller = TextEditingController();

  Login_Page({super.key});

  // login method
  void login(BuildContext context) async {
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(
          _emailcontroller.text, _pwcontroller.text);
    }

    // catch any errors
    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/images/START.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/images/rawmic17.png",
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "lib/images/RnPSoft.png", // path to the image
                      width: 120, // adjust width as needed
                      height: 120, // adjust height as needed
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
                // welcome back message----------------------------
                CText(
                  "Welcome Back, You have been missed!!",
                  color: Colors.white,
                  size: 13,
                ),
                const SizedBox(
                  height: 25,
                ),
                // email textfield---------------------------------
                MyTextField(
                  controller: _emailcontroller,
                  hintText: "   E-mail",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                // pw textfield ------------------------------------
                MyTextField(
                  controller: _pwcontroller,
                  hintText: "   Password",
                  obscureText: true,
                ),
                SizedBox(height: 35),
                // login button-------------------------------------
                MyButton(
                  text: "LOGIN",
                  onTap: () => login(context),
                ),
                SizedBox(
                  height: 35,
                ),
                // register now------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CText(
                      "New Employee? :  ",
                      color: Colors.white,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ));
                      },//child: "Register Now".text.size(13).fontWeight(FontWeight.bold).color(Mycolors.textcolorwhite).fontFamily("Poppins").underline.make(),
                      child: CText(
                        "Register Now",
                        weight: FontWeight.bold,
                        color: Colors.white,
                        size: 13,
                        underline: true,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
