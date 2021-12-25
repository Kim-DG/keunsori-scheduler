import 'package:flutter/material.dart';

class TextButtonFormat extends StatelessWidget {
  const TextButtonFormat({Key? key, this.text = '', this.letterSpacing = 0.0, this.onPressed}) : super(key: key);
  final String text;
  final double letterSpacing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'A',
            color: Colors.white70,
            letterSpacing: letterSpacing),
      ),
    );
  }
}
