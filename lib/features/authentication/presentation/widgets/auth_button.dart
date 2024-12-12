import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/theme/app_text_style.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  const AuthButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.gradient1,
            AppColors.gradient2,
            AppColors.gradient3,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
        ),
        child: Text(
          buttonText,
          style: textStyle ?? AppTextStyles.customButtonTextStyleSignIn,
        ),
      ),
    );
  }
}
