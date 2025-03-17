import 'dart:io';
import 'package:chat_menager/bloc/settings_bloc/settings_bloc.dart';
import 'package:chat_menager/components/custom_appBar/custom_appBar.dart';
import 'package:chat_menager/components/dialog/custom_alert_dialog.dart';
import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/settings_page_view/widgets/custom_settings_button.dart';
import 'package:chat_menager/views/sign_in_page_view/view/sign_in_page-view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({super.key});

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarView(
        appBarTitle: settings,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSettingsButton(
                  leadingIcon: rateUsIcon,
                  title: rateUs,
                  onTap: () async {},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: CustomSettingsButton(
                    leadingIcon: termOfUseIcon,
                    title: termOfUse,
                    onTap: () {},
                  ),
                ),
                CustomSettingsButton(
                  leadingIcon: contactUsIcon,
                  title: contactUs,
                  onTap: () async {},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: CustomSettingsButton(
                    leadingIcon: recommendIcon,
                    title: recommendText,
                    onTap: () {},
                  ),
                ),
                CustomSettingsButton(
                  leadingIcon: signOutIcon,
                  title: signOut,
                  textColor: customRed,
                  onTap: () async {
                    showCupertinoDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return CustomCupertinoAlertDialog(
                          title: settingsAlertTitleText,
                          content: settingsAlertSubtitleText,
                          noButtonOnTap: () {
                            Navigation.ofPop();
                          },
                          noButtonText: cancel,
                          yesButtonOnTap: () {
                            context.read<SettingsBloc>().add(SignOutEvent());
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPageView()),
                              (route) => false,
                            );
                          },
                          yesButtonText: ok,
                        );
                      },
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: CustomSettingsButton(
                    leadingIcon: deleteUserIcon,
                    textColor: customRed,
                    title: deleteUser,
                    onTap: () {
                      showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return CustomCupertinoAlertDialog(
                            title: deleteUserTextTitle,
                            content: settingsAlertSubtitleText,
                            noButtonOnTap: () {
                              Navigation.ofPop();
                            },
                            noButtonText: cancel,
                            yesButtonOnTap: () {},
                            yesButtonText: ok,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
