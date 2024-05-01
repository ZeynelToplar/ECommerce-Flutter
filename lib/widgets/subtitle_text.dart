import 'package:flutter/material.dart';

class SubTitleTextWidget extends StatelessWidget {

  final String label;
  final double fontSize;
  final FontStyle fontStyle;
  final FontWeight? fontWeight;
  final TextDecoration textDecoration;
  final Color? color;


  const SubTitleTextWidget({
      super.key,
      required this.label,
      this.fontSize = 16,
      this.fontStyle = FontStyle.normal,
      this.fontWeight = FontWeight.normal,
      this.textDecoration = TextDecoration.none,
      this.color
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        color: color,
        fontStyle: fontStyle,
      ),
    );
  }
}
