// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class TextWidgets extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  final String? family;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const TextWidgets({
    super.key,
    required this.text,
    this.color,
    required this.size,
    this.family,
    this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: size,
        fontFamily: family ?? "poppins",
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
  }
}
