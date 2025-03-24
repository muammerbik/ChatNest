import 'package:chat_menager/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/components/buttons/custom_bottom_bar.dart';
import 'package:chat_menager/components/buttons/custom_elevated_button.dart';
import 'package:chat_menager/components/buttons/custom_sing_in_button.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/components/custom_textFormField/custom_textForm_Field.dart';
import 'package:chat_menager/components/dialog/custom_alert_dialog.dart';
import 'package:chat_menager/components/dialog/custom_snackBar.dart';
import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/loading_page_view/loading_page.dart';
import 'package:chat_menager/views/sign_up_page_view/sign_up_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPageView extends StatefulWidget {
  const SignInPageView({super.key});

  @override
  State<SignInPageView> createState() => _SignInPageViewState();
}

class _SignInPageViewState extends State<SignInPageView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.status == SignInStatus.success) {
          if (state.userModel.userId.isEmpty) {
            showCupertinoDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return CustomCupertinoAlertDialog(
                  title: successful,
                  content: resetPassSubTitle,
                  yesButtonOnTap: () {
                    Navigation.ofPop();
                  },
                  yesButtonText: ok,
                );
              },
            );
          } else {
            context.read<SignUpBloc>().add(
                  CurrentUserStartEvent(),
                );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => BottomBar(),
              ),
              (route) => false,
            );
          }
        } else if (state.status == SignInStatus.error) {
          CustomSnackBar.show(
            context: context,
            message: signInErrorSnackBarText,
            containerColor: red,
            textColor: white,
          );
        }
      },
      builder: (context, state) {
        if (state.status == SignInStatus.loading) {
          return const LoadingPageView();
        } else {
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
                      signInImage,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                    TextWidgets(text: welcome, size: 24.sp),
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
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              showDragHandle: true,
                              backgroundColor: white,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context, setState) =>
                                      GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: FractionallySizedBox(
                                      heightFactor: 0.7,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.h, horizontal: 16.w),
                                        child: SizedBox(
                                          height: 300.h,
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 32.h,
                                              ),
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      'Şifrenizi sıfırlamak için hesabınızın kayıtlı olduğu epostanızı yazmanız gerekmektedir. Epostanıza sıfırlama linki gönderilecektir.',
                                                      style:
                                                          GoogleFonts.openSans(
                                                        color: black54,
                                                        fontSize: 14.sp,
                                                        textStyle:
                                                            const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 32.h,
                                              ),
                                              CustomTextFormField(
                                                controller: emailController,
                                                hintText: email,
                                                labelText:
                                                    'Şifre sıfırlama epostanızı giriniz',
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              CustomElevatedButtonView(
                                                text: "Gönder",
                                                color: customRed,
                                                textColor: white,
                                                onTop: () {
                                                  if (emailController
                                                      .text.isNotEmpty) {
                                                    context
                                                        .read<SignInBloc>()
                                                        .add(ResetPasswordEvent(
                                                            email:
                                                                emailController
                                                                    .text));
                                                    Navigation.ofPop();
                                                  } else {
                                                    CustomSnackBar.show(
                                                      context: context,
                                                      message:
                                                          "Lütfen e-posta adresinizi giriniz",
                                                      containerColor: red,
                                                      textColor: white,
                                                    );
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: TextWidgets(
                            text: forgotPass,
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
                        color: red,
                        textColor: Colors.white,
                        onTop: () {
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            context.read<SignInBloc>().add(
                                  SignInStartEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          } else {
                            CustomSnackBar.show(
                              context: context,
                              message: signInSnackBarText1,
                              containerColor: red,
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
                        context.read<SignInBloc>().add(
                              GoogleSignInEvent(),
                            );
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPageView(),
                                ),
                              );
                            },
                            child: TextWidgets(
                              text: signUp,
                              size: 14.sp,
                              color: red,
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
      },
    );
  }
}
