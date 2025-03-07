// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomSettingsButton extends StatefulWidget {
  final Color? buttonColor;
  final String leadingIcon;
  final Color? textColor;
  final VoidCallback onTap;
  final double? height;
  final String title;
  final double? fontSize;
  final Color? iconColor;
  const CustomSettingsButton({
    Key? key,
    this.buttonColor,
    required this.leadingIcon,
    this.textColor,
    required this.onTap,
    this.height,
    required this.title,
    this.fontSize,
    this.iconColor,
  }) : super(key: key);

  @override
  State<CustomSettingsButton> createState() => _CustomSettingsButtonState();
}

class _CustomSettingsButtonState extends State<CustomSettingsButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          height: widget.height ?? 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: widget.buttonColor ?? Colors.grey.shade100,
          ),
          child: ListTile(
            leading: Image.asset(
              widget.leadingIcon,
              color: widget.textColor ?? Colors.black,
            ),
            title: TextWidgets(
              text: widget.title,
              size: widget.fontSize ?? 16,
              color: widget.textColor ?? Colors.black,
              textAlign: TextAlign.start,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: widget.iconColor ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
