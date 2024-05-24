import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CText extends StatelessWidget {
  CText(this.text,
      {super.key,
      this.color = Colors.black,
      this.weight = FontWeight.normal,
      this.size = 12});
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

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontWeight: weight, fontSize: size),
    );
  }
}
