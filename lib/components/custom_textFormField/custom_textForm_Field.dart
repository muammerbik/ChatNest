import 'package:chat_menager/constants/app_strings.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final String? hintText;
  final int? maxLines;
  final Color? borderColor;
  final TextCapitalization? textCapitalization;
  final int? maxLength;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final Color? cursorColor;
  final String? initialValue;
  final bool? readOnly;
  final bool isPasswordField;

  const CustomTextFormField({
    super.key,
    this.labelText,
    this.controller,
    this.validator,
    this.onTap,
    this.isPasswordField = false,
    this.keyboardType,
    this.maxLength,
    this.hintText,
    this.maxLines,
    this.onSaved,
    this.borderColor,
    this.cursorColor,
    this.textCapitalization,
    this.obscureText = false,
    this.initialValue,
    this.readOnly,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextFormField(
        readOnly: widget.readOnly ?? false,
        initialValue: widget.initialValue,
        autofocus: false,
        cursorColor: widget.cursorColor ?? black,
        onSaved: widget.onSaved,
        maxLength: widget.maxLength,
        textInputAction: TextInputAction.done,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.words,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        onTap: widget.onTap,
        maxLines: widget.maxLines ?? 1,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            labelText: widget.labelText,
            hintText: widget.hintText,
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(24),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(24),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(24),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(24),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(24),
            ),
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: Icon(
                      _isVisible ? Icons.visibility : Icons.visibility_off,
                      color: black,
                    ),
                  )
                : null),
        obscureText: widget.isPasswordField && !_isVisible,
      ),
    );
  }
}
