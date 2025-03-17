import 'package:chat_menager/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:chat_menager/components/buttons/custom_bottom_bar.dart';
import 'package:chat_menager/components/buttons/custom_elevated_button.dart';
import 'package:chat_menager/components/buttons/custom_sing_in_button.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/components/custom_textFormField/custom_textForm_Field.dart';
import 'package:chat_menager/components/dialog/custom_snackBar.dart';
import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/sign_up_page_view/view/sign_up_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPageView extends StatefulWidget {
  const SignInPageView({super.key});

  @override
  State<SignInPageView> createState() => _SignInPageViewState();
}

class _SignInPageViewState extends State<SignInPageView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                signInImage,
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              TextWidgets(
                text: welcome,
                size: 24.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: TextWidgets(
                  text: signInSubTitle,
                  size: 16.sp,
                  color: black54,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: CustomTextFormField(
                  controller: emailController,
                  hintText: email,
                  labelText: email,
                ),
              ),
              CustomTextFormField(
                controller: passwordController,
                hintText: password,
                labelText: password,
                isPasswordField: true,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: TextWidgets(
                      text: "Şifremi Unuttum",
                      size: 14.sp,
                      color: grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: CustomElevatedButtonView(
                  text: signIn,
                  color: customRed,
                  textColor: white,
                  onTop: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      context.read<SignInBloc>().add(
                            SignInStartEvent(
                                email: emailController.text,
                                password: passwordController.text),
                          );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomBar(),
                        ),
                        (route) => false,
                      );
                    } else {
                      CustomSnackBar.show(
                        context: context,
                        message: signInSnackBar,
                        containerColor: customRed,
                        textColor: white,
                      );
                    }
                  },
                ),
              ),
              CustomSingInButton(
                iconWidget: Image.asset(
                  googleIcon,
                  fit: BoxFit.contain,
                  width: 24.w,
                ),
                text: googleWithSignIn,
                onTop: () {
                  context.read<SignInBloc>().add(GoogleSignInEvent());
                },
                color: white,
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidgets(
                      text: signInSubTitle2,
                      size: 14.sp,
                      color: grey,
                      fontWeight: FontWeight.normal,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigation.push(
                          page: SignUpPageView(),
                        );
                      },
                      child: TextWidgets(
                        text: signUp,
                        size: 14.sp,
                        color: customRed,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
