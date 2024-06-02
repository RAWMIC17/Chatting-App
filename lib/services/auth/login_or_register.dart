import 'package:chatting_app_1/pages/page_login.dart';
import 'package:chatting_app_1/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // intitially, show login page
  bool showLoginPage = true;

  // toggle between  login and register pages
  void togglePages() {
    setState(() {
      print("-----------------------${showLoginPage}");
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login_Page();
    } else {
      return RegisterPage();
    }
  }
}
