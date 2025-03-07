import 'package:chat_menager/components/custom_appBar/custom_appBar.dart';
import 'package:chat_menager/components/custom_textFormField/custom_textForm_Field.dart';
import 'package:chat_menager/views/profile_page_view/widgets/add_image_widget.dart';
import 'package:chat_menager/views/settings_page_view/view/settings_page-view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({Key? key}) : super(key: key);

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarView(
        appBarTitle: 'Profil',
        centerTitle: false,
        textColor: Colors.black,
        actionIcons: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingsPageView(),
                ),
              );
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
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
                hintText: "İsim ",
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: CustomTextFormField(
                  controller: surnameController,
                  hintText: "Soyisim ",
                ),
              ),
              CustomTextFormField(
                controller: emailController,
                hintText: "Email ",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
