import 'package:chatting_app_1/services/auth/auth_service.dart';
import 'package:chatting_app_1/models/custom_text.dart';
import 'package:chatting_app_1/models/my_button.dart';
import 'package:chatting_app_1/models/my_textfield.dart';
import 'package:chatting_app_1/pages/page_login.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();
  final TextEditingController _confirmcontroller = TextEditingController();
  final TextEditingController _usercontroller = TextEditingController();

  RegisterPage({super.key});

  //to fetch username and show it in chat home screen
  String getUsername() {
    return _usercontroller.text;
  }

  // register function
  void register(BuildContext context) async {
    //create AuthService
    final authService = AuthService();

    //password match -> create user
    if (_pwcontroller.text == _confirmcontroller.text &&
        _pwcontroller.text.length > 6) {
      try {
        await authService.signUpWithEmailPassword(
            _emailcontroller.text, _pwcontroller.text, getUsername());
      } catch (e) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  title: Text(e.toString()),
                )));
      }
    }

    // if passes don't match -> show error to user
    else {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: Text("Passwords don't match!"),
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // ------background image------------
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
            // ---------upper logo-------------------
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/images/RnPSoft.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 50),
                CText(
                  "Register your new employees here",
                  color: Colors.white,
                ),
                // --------EMAIL TEXTFIELD---------------
                const SizedBox(height: 10),
                MyTextField(
                  controller: _emailcontroller,
                  hintText: "E-mail",
                  obscureText: false,
                ),
                // --------USERNAME TEXTFIELD-------------
                const SizedBox(height: 10),
                MyTextField(
                  controller: _usercontroller,
                  hintText: "Username",
                  obscureText: false,
                ),
                // -------PASSWORD TEXTFIELD-------------
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: _pwcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password should contain at least 6 characters';
                      }
                      return null; // Return null if the validation succeeds
                    },
                  ),
                ),
                // -----CONFIRM PW TEXTFIELD-------------
                SizedBox(height: 10),
                MyTextField(
                  controller: _confirmcontroller,
                  hintText: "Confirm password",
                  obscureText: true,
                ),
                // -----REGISTER BUTTON------------------
                SizedBox(height: 25),
                MyButton(
                  text: "REGISTER",
                  onTap: () => register(context),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CText(
                      "Already registered? ",
                      color: Colors.white,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login_Page(),
                          ),
                        );
                      },
                      // -----GO TO LOGIN PAGE-------------
                      child: CText(
                        "Login Now",
                        weight: FontWeight.bold,
                        color: Colors.white,
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
