import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color bgColor;
  final Color hintColor;
  final double borderRadius;
  final TextAlign textAlign;
  final int? maxLines;
  final int? minLines;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool readOnly;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry contentPadding;
  final Color? borderColor; // ✅ New optional border color

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.bgColor = const Color(0xFFE0E0E0),
    this.hintColor = Colors.grey,
    this.borderRadius = 1,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.minLines,
    this.hintStyle,
    this.textStyle,
    this.readOnly = false,
    this.onTap,
    this.focusNode,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.borderColor, // ✅ Added to constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      focusNode: focusNode,
      textAlign: textAlign,
      maxLines: maxLines,
      minLines: minLines,
      style: textStyle ?? const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ?? TextStyle(color: hintColor, fontSize: 15),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: bgColor,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? Theme.of(context).primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
