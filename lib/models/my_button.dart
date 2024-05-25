import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Mycolors.purplecolor,
            borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          text,
          style: TextStyle(fontSize: 25, color: Mycolors.textcolorwhite),
        )),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 25),
      ),
    );
  }
}
