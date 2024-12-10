import 'package:flutter/material.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/theme/app_text_style.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final TextStyle? textStyle;
  final VoidCallback? onLongPress;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.onLongPress,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress, //-------Temp use------------
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        minimumSize: const Size(250, 50),
      ),
      child: Text(
        text,
        style: textStyle ?? AppTextStyles.customButtonTextStyleSignIn,
      ),
    );
  }
}
