import 'package:chat_menager/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class EmptyPageView extends StatelessWidget {
  const EmptyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250.w,
              child: Lottie.asset(
                'assets/jsonfiles/empty.json',
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'Bu sayfada henüz bir veri\nyok gibi gözüküyor.',
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                color: Colors.grey,
                fontSize: 16.sp,
                textStyle: const TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
