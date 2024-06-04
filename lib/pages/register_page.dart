import 'package:chatting_app_1/services/auth/auth_service.dart';
import 'package:chatting_app_1/models/custom_text.dart';
import 'package:chatting_app_1/models/my_button.dart';
import 'package:chatting_app_1/models/my_textfield.dart';
import 'package:chatting_app_1/pages/page_login.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _pwcontroller = TextEditingController();

  final TextEditingController _confirmcontroller = TextEditingController();

  final TextEditingController _usercontroller = TextEditingController();

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
                const SizedBox(height: 30),
                CText(
                  "Register your new employees here",
                  color: Colors.white,
                ),
                // --------EMAIL TEXTFIELD---------------
                SizedBox(height: 20),
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
               SizedBox(height: 10),
                Container(height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    controller: _pwcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(70.0),
            ),
                        enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(70)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary)),
                        focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(70.0),
            ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Password",
                        hintStyle: TextStyle(
                color: Mycolors.buttongraycolor,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w300,
                fontSize: 14)),
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
                  text: "Register",
                  onTap: () {
                    if (_emailcontroller.text.isEmpty ||
        _usercontroller.text.isEmpty ||
        _pwcontroller.text.isEmpty ||
        _confirmcontroller.text.isEmpty) {
      // Show error message if any of the fields are empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill in all fields"),
        duration: Duration(milliseconds: 1200),
      ));
    } else {
      // All fields are filled, proceed with registration
      register(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Registered Successfully"),
        duration: Duration(milliseconds: 1200),
      ));
    }
                  },
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CText(
                      "Already registered? : ",
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
