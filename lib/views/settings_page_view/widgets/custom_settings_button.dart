// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    super.key,
    this.buttonColor,
    required this.leadingIcon,
    this.textColor,
    required this.onTap,
    this.height,
    required this.title,
    this.fontSize,
    this.iconColor,
  });

  @override
  State<CustomSettingsButton> createState() => _CustomSettingsButtonState();
}

class _CustomSettingsButtonState extends State<CustomSettingsButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          height: widget.height ?? 64.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36.r),
            color: widget.buttonColor ?? grey100,
          ),
          child: ListTile(
            leading: Image.asset(
              widget.leadingIcon,
              color: widget.textColor ?? black,
              fit: BoxFit.cover,
              height: 28.h,
            ),
            title: TextWidgets(
              text: widget.title,
              size: widget.fontSize ?? 16.sp,
              color: widget.textColor ?? black,
              textAlign: TextAlign.start,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: widget.iconColor ?? black,
            ),
          ),
        ),
      ),
    );
  }
}
