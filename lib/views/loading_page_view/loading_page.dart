import 'package:chat_menager/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingPageView extends StatelessWidget {
  const LoadingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: SizedBox(
          height: 250.h,
          width: 250.w,
          child: Lottie.asset(loadingJson),
        ),
      ),
    );
  }
}
