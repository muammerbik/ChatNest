// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarView extends StatefulWidget implements PreferredSizeWidget {
  final String? appBarTitle;
  final bool? centerTitle;
  final List<IconButton>? actionIcons;
  final Color? appBarColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final Color? iconColor;
  final IconButton? leadingIcon;
  final Widget? customTitle;

  const CustomAppBarView({
    super.key,
    this.appBarTitle,
    this.centerTitle,
    this.actionIcons,
    this.appBarColor,
    this.textColor,
    this.onTap,
    this.iconColor,
    this.leadingIcon,
    this.customTitle,
  });

  @override
  State<CustomAppBarView> createState() => _CustomAppBarViewState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarViewState extends State<CustomAppBarView> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        surfaceTintColor: white,
        centerTitle: widget.centerTitle ?? false,
        leadingWidth: 30,
        backgroundColor: widget.appBarColor ?? white,
        leading: widget.leadingIcon,
        title: widget.customTitle ?? TextWidgets(
          text: widget.appBarTitle!,
          size: 24.sp,
          color: widget.textColor ?? black,
        ),
        actions: widget.actionIcons ?? []);
  }
}
