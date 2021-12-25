import 'package:flutter/material.dart';

class TextFormat extends StatelessWidget {
  const TextFormat(
      {Key? key,
      this.text = '',
      this.wordSpacing = 0.0,
      this.color = Colors.white,
      this.fontSize = 40.0, this.letterSpacing = 10.0, this.decoration})
      : super(key: key);
  final String text;
  final double wordSpacing;
  final Color color;
  final double fontSize;
  final double letterSpacing;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'A',
          color: color,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          decoration: decoration
        ));
  }
}
