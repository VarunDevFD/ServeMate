import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

class DialogUtils {
  // ScaffoldMessenger

  // Info
  static void showInfoMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info, color: AppColors.white),
            SizedBox(width: 8.w),
            Text(message),
          ],
        ),
        elevation: 6,
        backgroundColor: AppColors.orange,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  // Error
  static void showErrorMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: AppColors.white),
            SizedBox(width: 8.w),
            Text(message),
          ],
        ),
        elevation: 6,
        backgroundColor: AppColors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  // Success
  static void showSuccessMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: AppColors.white),
            SizedBox(width: 8.w),
            Text(message),
          ],
        ),
        elevation: 6,
        backgroundColor: AppColors.greenLight,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  // AlertBox
  static void showStepDialog({
    required BuildContext context,
    required String mainTitle,
    required String mainContent,
    required VoidCallback onConfirmed,
    VoidCallback? onSkip,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(mainTitle),
        content: Text(mainContent),
        actions: [
          TextButton(
            onPressed: () {
              if (onSkip != null) {
                onSkip();
              } else {
                context.pop();
              }
            },
            child: const Text(
              'Skip',
              style: TextStyle(color: AppColors.black54),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirmed();
            },
            child: Text(
              'Allow',
              style: TextStyle(color: AppColors.green),
            ),
          ),
        ],
      ),
    );
  }
}
