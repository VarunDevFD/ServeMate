import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/theme/app_text_style.dart';

class CustomElevatedButton extends StatelessWidget {
  late String text;
  late VoidCallback onPressed;
  late Color? backgroundColor;
  late Color? textColor;
  late double? borderRadius;
  late TextStyle? textStyle;

  CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
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
