import 'package:flutter/material.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

class SnackBarUtils {
  // A static method to show snack bars
  static void showSnackBar(BuildContext context, String message,
      {Color backgroundColor = AppColors.error}) {
    // Clear any existing SnackBars to avoid stacking
    ScaffoldMessenger.of(context).clearSnackBars();

    // Show the new SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior
            .floating, // Keeps it above the bottom navigation bar (if any)
        duration: const Duration(seconds: 2), // Default duration
      ),
    );
  }
}
