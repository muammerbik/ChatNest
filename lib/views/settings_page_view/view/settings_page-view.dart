import 'dart:io';
import 'package:chat_menager/bloc/settings_bloc/settings_bloc.dart';
import 'package:chat_menager/components/custom_appBar/custom_appBar.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/settings_page_view/widgets/custom_settings_button.dart';
import 'package:chat_menager/views/sign_in_page_view/view/sign_in_page-view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({Key? key}) : super(key: key);

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<SettingsBloc, SettingsState>(
            listener: (context, state) {
              if (state.status == SettingsStatus.success) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPageView()),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: CustomAppBarView(
                  appBarTitle: "Ayarlar",
                  textColor: black,
                  centerTitle: true,
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
                            leadingIcon: "assets/icons/stng2.png",
                            onTap: () async {},
                            title: "Rate Us",
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: CustomSettingsButton(
                              leadingIcon: "assets/icons/stng3.png",
                              onTap: () {},
                              title: "Term of Use",
                            ),
                          ),
                          CustomSettingsButton(
                            leadingIcon: "assets/icons/stng5.png",
                            onTap: () async {},
                            title: "Contact Us",
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: CustomSettingsButton(
                              leadingIcon: "assets/icons/stng1.png",
                              onTap: () {},
                              title: "Recommend to Friend",
                            ),
                          ),
                          CustomSettingsButton(
                            leadingIcon: "assets/icons/stng5.png",
                            onTap: () async {
                              context.read<SettingsBloc>().add(SignOutEvent());
                            },
                            title: "Sign Out",
                          ),
                          if (state.status == SettingsStatus.loading)
                            const CircularProgressIndicator(),
                          if (state.status == SettingsStatus.error)
                            Text("Error occurred during sign up",
                                style: TextStyle(color: Colors.red)),
                        ],
                      ),
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
