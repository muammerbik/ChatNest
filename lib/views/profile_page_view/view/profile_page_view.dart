import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/components/buttons/custom_elevated_button.dart';
import 'package:chat_menager/components/custom_appBar/custom_appBar.dart';
import 'package:chat_menager/components/custom_textFormField/custom_textForm_Field.dart';
import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/loading_page_view/loading_page.dart';
import 'package:chat_menager/views/profile_page_view/widgets/add_image_widget.dart';
import 'package:chat_menager/views/settings_page_view/view/settings_page-view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Get user data from SignUpBloc state
    final userModel = context.read<SignUpBloc>().state.userModel;
    
    // Initialize controllers with user data
    emailController.text = userModel.email;
    nameController.text = userModel.userName ?? '';
    surnameController.text = userModel.surname ?? '';
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  Future<void> _updateUserInfo() async {
    final userModel = context.read<SignUpBloc>().state.userModel;
    final repository = context.read<SignUpBloc>().repository;

    if (nameController.text != userModel.userName) {
      await repository.updateUserName(userModel.userId, nameController.text);
    }

    if (surnameController.text != userModel.surname) {
      await repository.updateSurname(userModel.userId, surnameController.text);
    }

    // Refresh user data
    context.read<SignUpBloc>().add(CurrentUserStartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == SignUpStatus.loading) {
          return LoadingPageView();
        } else {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: CustomAppBarView(
              appBarTitle: profile,
              actionIcons: [
                IconButton(
                  onPressed: () {
                    Navigation.push(
                      page: SettingsPageView(),
                    );
                  },
                  icon: Icon(
                    Icons.settings,
                    color: black,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.w),
                        child: AddImageWidgets(),
                      ),
                      CustomTextFormField(
                        controller: nameController,
                        hintText: name,
                        labelText: name,
                        readOnly: false,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: CustomTextFormField(
                          controller: surnameController,
                          hintText: surname,
                          labelText: surname,
                          readOnly: false,
                        ),
                      ),
                      CustomTextFormField(
                        controller: emailController,
                        hintText: email,
                        labelText: email,
                        readOnly: true,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: CustomElevatedButtonView(
                          text: save,
                          color: customRed,
                          textColor: white,
                          onTop: _updateUserInfo,
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
