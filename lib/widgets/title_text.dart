import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {

  final String label;
  final double fontSize;
  final FontStyle fontStyle;
  final FontWeight? fontWeight;
  final TextDecoration textDecoration;
  final Color? color;


  const TitleTextWidget({
    super.key,
    required this.label,
    this.fontSize = 20,
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
