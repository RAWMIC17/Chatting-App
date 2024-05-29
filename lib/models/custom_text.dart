import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CText extends StatelessWidget {
  CText(
    this.text, {
    super.key,
    this.color = Colors.black,
    this.weight = FontWeight.normal,
    this.size = 12,
    this.underline = false,
  });
  String text;
  Key? key;
  TextStyle? style;
  StrutStyle? strutStyle;
  TextAlign? textAlign;
  TextDirection? textDirection;
  Locale? locale;
  bool? softWrap;
  TextOverflow? overflow;
  double? textScaleFactor;
  TextScaler? textScaler;
  int? maxLines;
  String? semanticsLabel;
  TextWidthBasis? textWidthBasis;
  TextHeightBehavior? textHeightBehavior;
  Color? selectionColor;
  FontWeight weight = FontWeight.normal;
  double size = 12;
  Color color = Colors.black;
  bool underline;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: weight,
          fontSize: size,
          fontFamily: "Poppins",
          decoration:
              underline ? TextDecoration.underline : TextDecoration.none,
          decorationColor: Mycolors.textcolorwhite,
          decorationThickness: 2.5,),
    );
  }
}
