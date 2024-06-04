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
        //color: Vx.red500,
        width: MediaQuery.of(context).size.width - 100, //double.infinity,
        decoration: BoxDecoration(
            color: Mycolors.purplecolor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          text,
          style: TextStyle(fontSize: 23, color: Mycolors.textcolorwhite,fontFamily: "Poppins"),
        )),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      ),
    );
  }
}
