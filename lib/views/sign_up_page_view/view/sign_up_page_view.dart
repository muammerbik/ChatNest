import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/components/buttons/custom_bottom_bar.dart';
import 'package:chat_menager/components/buttons/custom_elevated_button.dart';
import 'package:chat_menager/components/buttons/custom_sing_in_button.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/components/custom_textFormField/custom_textForm_Field.dart';
import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/sign_in_page_view/view/sign_in_page-view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPageView extends StatefulWidget {
  const SignUpPageView({super.key});

  @override
  State<SignUpPageView> createState() => _SignUpPageViewState();
}

class _SignUpPageViewState extends State<SignUpPageView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state.status == SignUpStatus.success) {
                Text("Sign up successful!");
              }
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomBar(),
                ),
                (route) => false,
              );
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
                        Image.asset(
                          "assets/images/sign_up.png",
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                        TextWidgets(text: "Hesap Oluştur", size: 24.sp),
                        TextWidgets(
                          text: "Hemen kayıt ol ve mesajlaşmaya başla!",
                          size: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: CustomTextFormField(
                            controller: nameController,
                            hintText: "İsim giriniz",
                          ),
                        ),
                        CustomTextFormField(
                          controller: surnameController,
                          hintText: "Soyisim giriniz",
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: CustomTextFormField(
                            controller: emailController,
                            hintText: "Email giriniz",
                          ),
                        ),
                        CustomTextFormField(
                          controller: passwordController,
                          hintText: "Şifre giriniz",
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: CustomElevatedButtonView(
                            text: "Hesap Oluştur",
                            color: customRed,
                            textColor: Colors.white,
                            onTop: () {
                              context.read<SignUpBloc>().add(
                                    SignUpStartEvent(
                                      name: nameController.text,
                                      surname: surnameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
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
                          text: "Google ile Kayıt Ol",
                          onTop: () {},
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidgets(
                                text: "Hesabın var mı?",
                                size: 14.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigation.push(
                                    page: SignInPageView(),
                                  );
                                },
                                child: TextWidgets(
                                  text: "Giriş Yap",
                                  size: 14.sp,
                                  color: customRed,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (state.status == SignUpStatus.loading)
                          CircularProgressIndicator(),
                        if (state.status == SignUpStatus.error)
                          Text("Error occurred during sign up",
                              style: TextStyle(color: Colors.red)),
                        if (state.status == SignUpStatus.success)
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
