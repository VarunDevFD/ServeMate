import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  late TextEditingController controller;
  late String labelText;
  final String hintText;
  late bool isPassword;
  late IconData? icon;
  late void Function(String)? onSubmitted;
  late FocusNode? focusNode;
  late bool obscureText; // To control the password visibility
  late VoidCallback? onToggleVisibility; // Callback to handle visibility toggle
  late FormFieldValidator<String>? validator;
  late Widget? suffixIcon;

  CustomTextField({
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
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
    );
  }
}
