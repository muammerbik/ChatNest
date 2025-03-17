import 'package:chat_menager/constants/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCupertinoAlertDialog extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback yesButtonOnTap;
  final VoidCallback? noButtonOnTap;
  final String? yesButtonText;
  final String? noButtonText;

  const CustomCupertinoAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.yesButtonOnTap,
    this.noButtonOnTap,
    this.yesButtonText,
    this.noButtonText,
  });

  @override
  State createState() => _CustomCupertinoAlertDialogState();
}

class _CustomCupertinoAlertDialogState
    extends State<CustomCupertinoAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        widget.title,
        style: TextStyle(color: black, fontSize: 20.sp),
      ),
      content: Text(
        widget.content,
        style: TextStyle(fontSize: 15.sp, color: black),
      ),
      actions: [
        if (widget.noButtonOnTap != null && widget.noButtonText != null)
          CupertinoDialogAction(
            onPressed: widget.noButtonOnTap,
            child: Text(
              widget.noButtonText ?? cancel,
              style: TextStyle(
                color: CupertinoColors.systemBlue,
              ),
            ),
          ),
        CupertinoDialogAction(
          onPressed: widget.yesButtonOnTap,
          child: Text(
            widget.yesButtonText ?? "ok",
            style: TextStyle(
              color: CupertinoColors.destructiveRed,
            ),
          ),
        ),
      ],
    );
  }
}
