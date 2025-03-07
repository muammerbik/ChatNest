import 'package:chat_menager/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:chat_menager/components/buttons/custom_bottom_bar.dart';
import 'package:chat_menager/components/buttons/custom_elevated_button.dart';
import 'package:chat_menager/components/buttons/custom_sing_in_button.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/components/custom_textFormField/custom_textForm_Field.dart';
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
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<SignInBloc, SignInState>(
            listener: (context, state) {
              if (state.status == SignInStatus.success) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BottomBar()),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
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
                          "assets/images/online_message.png",
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                        TextWidgets(
                          text: "Hoş Geldiniz!",
                          size: 24.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: TextWidgets(
                            text: "Hesabınıza giriş yapın",
                            size: 16.sp,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: CustomTextFormField(
                            controller: emailController,
                            hintText: "E-mail giriniz",
                          ),
                        ),
                        CustomTextFormField(
                          controller: passwordController,
                          hintText: "Şifre giriniz",
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
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: CustomElevatedButtonView(
                            text: "Giriş Yap",
                            color: customRed,
                            textColor: Colors.white,
                            onTop: () {
                              context.read<SignInBloc>().add(
                                    SignInStartEvent(
                                        email: emailController.text,
                                        password: passwordController.text),
                                  );
                            },
                          ),
                        ),
                        CustomSingInButton(
                          iconWidget: Image.asset(
                            "assets/images/google.png",
                            fit: BoxFit.contain,
                            width: 24.w,
                          ),
                          text: "Google ile Giriş",
                          onTop: () {
                            context.read<SignInBloc>().add(GoogleSignInEvent());
                          },
                          color: Colors.white,
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidgets(
                                text: "Hesabın yok mu?",
                                size: 14.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigation.push(
                                    page: SignUpPageView(),
                                  );
                                },
                                child: TextWidgets(
                                  text: "Kayıt ol",
                                  size: 14.sp,
                                  color: customRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (state.status == SignInStatus.loading)
                          CircularProgressIndicator(),
                        if (state.status == SignInStatus.error)
                          Text("Error occurred during sign up",
                              style: TextStyle(color: Colors.red)),
                        if (state.status == SignInStatus.success)
                          Text("Sign up successful!"),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
