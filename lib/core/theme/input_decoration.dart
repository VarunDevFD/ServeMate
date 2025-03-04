import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

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
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.redAccent),
      ),
      suffixIcon: suffixIcon, // Allow for an optional suffix icon
    );
  }
}
