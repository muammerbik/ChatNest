import 'package:chat_menager/components/buttons/custom_elevated_button.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/sign_in_page_view/sign_in_page-view.dart';
import 'package:chat_menager/views/sign_up_page_view/sign_up_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                onboardingImage,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: TextWidgets(
                  text: onboardingTitle,
                  size: 24.sp,
                ),
              ),
              TextWidgets(
                text: onboardingSubTitle,
                size: 16.sp,
                color: black54,
                fontWeight: FontWeight.normal,
              ),
              const Spacer(),
              CustomElevatedButtonView(
                text: signIn,
                color: customRed,
                textColor: white,
                onTop: () {
                  Navigation.pushAndRemoveAll(
                    page: SignInPageView(),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 44.h, top: 16.h),
                child: CustomElevatedButtonView(
                  text: signUp,
                  color: white,
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
