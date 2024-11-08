import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isPassword;
  final IconData? icon;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final bool obscureText; // To control the password visibility
  final VoidCallback?
      onToggleVisibility; // Callback to handle visibility toggle
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    this.icon,
    this.onSubmitted,
    this.focusNode,
    required this.obscureText,
    this.onToggleVisibility,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText, // Password visibility control
      focusNode: focusNode,
      onFieldSubmitted: onSubmitted,
      validator: validator, // Use validator
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.blue, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.grey, width: 1.0),
        ),
      ),
    );
  }
}
