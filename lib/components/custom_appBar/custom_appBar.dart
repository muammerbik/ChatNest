// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppBarView extends StatefulWidget implements PreferredSizeWidget {
  final String? appBarTitle;
  final bool? centerTitle;
  final List<IconButton>? actionIcons;
  final Color? appBarColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final Color? iconColor;
  final IconButton? leadingIcon;

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
        surfaceTintColor: Colors.white,
        centerTitle: widget.centerTitle,
        backgroundColor: widget.appBarColor ?? Colors.white,
        leading: widget.leadingIcon,
        title: TextWidgets(
          text: widget.appBarTitle!,
          size: 24,
          color: widget.textColor ?? Colors.black,
        ),
        actions: widget.actionIcons ?? []);
  }
}
