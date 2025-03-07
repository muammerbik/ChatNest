import 'package:chat_menager/components/buttons/custom_elevated_button.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/sign_in_page_view/view/sign_in_page-view.dart';
import 'package:chat_menager/views/sign_up_page_view/view/sign_up_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                "assets/images/messaging.png",
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: TextWidgets(
                  text:
                      "Arkadaşlarınla güvenli ve\nhızlı bir şekilde sohbet et!",
                  size: 24.sp,
                ),
              ),
              TextWidgets(
                text: "Mesajlaşmanın en kolay yolu",
                size: 16.sp,
                color: Colors.black54,
                fontWeight: FontWeight.normal,
              ),
              const Spacer(),
              CustomElevatedButtonView(
                text: "Giriş Yap",
                color: customRed,
                textColor: Colors.white,
                onTop: () {
                  Navigation.pushAndRemoveAll(
                    page: SignInPageView(),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 44.h, top: 16.h),
                child: CustomElevatedButtonView(
                  text: "Hesap Oluştur",
                  color: Colors.white,
                  textColor: customRed,
                  borderColor: customRed,
                  onTop: () {
                    Navigation.pushAndRemoveAll(
                      page: SignUpPageView(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




   /*  Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: grey.shade50,
                    borderRadius: BorderRadius.circular(30),
                    border:
                        Border.all(color: black.withOpacity(0.5), width: 2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      singIn,
                      style: TextStyle(
                        fontSize: 45.sp,
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    CustomSingInButton(
                      text: googlSsingIn,
                      color: white,
                      onTop: () {
                     
                      },
                      iconWidget: Image.asset(
                        "assets/images/google.png",
                        fit: BoxFit.contain,
                        width: 40.w,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomSingInButton(
                      text: emailSingIn,
                      onTop: () {
                        emailAndPasswordWithSingIn(context);
                      },
                      color: white,
                      iconWidget: Image.asset(
                        "assets/images/gmail.png",
                        fit: BoxFit.contain,
                        width: 40.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ), */
       