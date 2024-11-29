import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/theme/app_colors.dart';

class InputDecorations {
  static InputDecoration defaultDecoration({
    String? labelText,
    String? hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
    String? errorText,
  }) {
    return InputDecoration(
      labelText: labelText,
      errorText: errorText,
      hintText: hintText,
      border: const OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.redAccent),
      ),
      suffixIcon: suffixIcon, // Allow for an optional suffix icon
    );
  }
}
