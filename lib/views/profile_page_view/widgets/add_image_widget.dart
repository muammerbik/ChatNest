import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/profile_page_view/widgets/action_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddImageWidgets extends StatefulWidget {
  const AddImageWidgets({super.key});

  @override
  State<AddImageWidgets> createState() => _AddImageWidgetsState();
}

class _AddImageWidgetsState extends State<AddImageWidgets> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Resim seçilirken bir hata oluştu"),
            ),
          );
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              showCustomActionSheet(
                context,
                () {
                  context.read<SignUpBloc>().add(PickImageFromCameraEvent());
                },
                () {
                  context.read<SignUpBloc>().add(PickImageFromGalleryEvent());
                },
              );
            },
            child: Stack(
              children: [
                Container(
                  height: 164.h,
                  width: 164.h,
                  decoration: BoxDecoration(
                    color: white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: grey,
                    ),
                  ),
                  child: ClipOval(
                    child: state.imageFile != null
                        ? Image.file(
                            state.imageFile!,
                            fit: BoxFit.cover,
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 42.w),
                            child: Image.asset(cameraImage),
                          ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    height: 48.h,
                    width: 48.h,
                    decoration: const ShapeDecoration(
                      color: customDarkGreen,
                      shape: OvalBorder(
                        side: BorderSide(width: 1, color: grey),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                      child: Image.asset(
                        cameraImage,
                        color: white,
                        height: 24.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showCustomActionSheet(
    BuildContext context,
    VoidCallback cameraTapped,
    VoidCallback galleryTapped,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ActionSheet(
          cameraTapped: cameraTapped,
          galleryTapped: galleryTapped,
        );
      },
    );
  }
}
