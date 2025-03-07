// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppbarView extends StatefulWidget implements PreferredSizeWidget {
  final String? appBarTitle;
  final bool? centerTitle;
  final List<IconButton>? actionIcons;
  final Color? appbarColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final Color? iconColor;
  final IconButton? leadingIcon; // Yeni parametre eklendi

  const CustomAppbarView({
    Key? key,
    this.appBarTitle,
    this.centerTitle,
    this.actionIcons,
    this.appbarColor,
    this.textColor,
    this.onTap,
    this.iconColor,
    this.leadingIcon, // Yeni parametreye ekledik
  }) : super(key: key);

  @override
  State<CustomAppbarView> createState() => _CustomAppbarViewState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppbarViewState extends State<CustomAppbarView> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: widget.centerTitle,
        backgroundColor: widget.appbarColor ?? Colors.white,
        leading: widget.leadingIcon ?? null,
        title: TextWidgets(
          text: widget.appBarTitle!,
          size: 24,
          color: widget.textColor ?? Colors.black,
        ),
        actions: widget.actionIcons ?? []);
  }
}

/** IconButton(
        onPressed: widget.onTap,
        icon: Icon(
          Icons.arrow_back,
          color: widget.iconColor ?? Colors.black,
        ),
      ), */
