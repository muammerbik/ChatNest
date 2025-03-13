import 'package:chat_menager/constants/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorPageview extends StatelessWidget {
  final bool? canBack;
  const ErrorPageview({super.key, this.canBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: 250.h,
              width: 250.w,
              child: Lottie.asset(
                'assets/jsonfiles/404.json',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
