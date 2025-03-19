import 'package:chat_menager/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/components/buttons/custom_bottom_bar.dart';
import 'package:chat_menager/components/buttons/custom_elevated_button.dart';
import 'package:chat_menager/components/buttons/custom_sing_in_button.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/components/custom_textFormField/custom_textForm_Field.dart';
import 'package:chat_menager/components/dialog/custom_snackBar.dart';
import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/loading_page_view/loading_page.dart';
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
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.success) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomBar()),
            (route) => false,
          );
        } else if (state.status == SignUpStatus.error) {
          CustomSnackBar.show(
            context: context,
            message: signUpSnackBar,
            containerColor: customRed,
            textColor: white,
          );
        }
      },
      builder: (context, state) {
        if (state.status == SignUpStatus.loading) {
          return const LoadingPageView();
        } else {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        signUpImage,
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                      TextWidgets(text: signUp, size: 24.sp),
                      TextWidgets(
                        text: signUpSubTitle,
                        size: 16.sp,
                        fontWeight: FontWeight.normal,
                        color: black54,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: CustomTextFormField(
                          controller: nameController,
                          hintText: name,
                          labelText: name,
                        ),
                      ),
                      CustomTextFormField(
                        controller: surnameController,
                        hintText: surname,
                        labelText: surname,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: CustomTextFormField(
                          controller: emailController,
                          hintText: email,
                          labelText: email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        hintText: password,
                        labelText: password,
                        isPasswordField: true,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: CustomElevatedButtonView(
                          text: signUp,
                          color: customRed,
                          textColor: white,
                          onTop: () {
                            if (nameController.text.isNotEmpty &&
                                surnameController.text.isNotEmpty &&
                                emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              context.read<SignUpBloc>().add(
                                    SignUpStartEvent(
                                      name: nameController.text,
                                      surname: surnameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
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
                                message: signUpSnackBar,
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
                        text: googleSignUpText,
                        onTop: () {
                          context.read<SignInBloc>().add(GoogleSignInEvent());
                        },
                        color: white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidgets(
                              text: signUpText2,
                              size: 14.sp,
                              color: grey,
                              fontWeight: FontWeight.normal,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigation.push(
                                  page: SignInPageView(),
                                );
                              },
                              child: TextWidgets(
                                text: signIn,
                                size: 14.sp,
                                color: customRed,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
