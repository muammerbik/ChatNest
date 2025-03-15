// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      style: GoogleFonts.ubuntu(
        color: color ?? Colors.black,
        fontSize: size,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
  }
}
