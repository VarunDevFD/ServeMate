// lib/core/widgets/custom_text.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serve_mate/core/utils/theme/app_colors.dart';

enum TextStyleType {
  title,
  subtitle,
  body,
  caption,
  label,
  custom,
}

class CustomText extends StatelessWidget {
  final String text;
  final TextStyleType styleType;
  final TextStyle? customStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText({
    super.key,
    required this.text,
    this.styleType = TextStyleType.body,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getTextStyle(),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextStyle _getTextStyle() {
    switch (styleType) {
      case TextStyleType.title:
        return GoogleFonts.abel(
          fontSize: 30.sp,
          color: AppColors.white,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
          shadows: [
            Shadow(
              color: AppColors.balck1,
              offset: const Offset(3, 3),
              blurRadius: 8,
            ),
            Shadow(
              color: AppColors.balck2,
              offset: const Offset(6, 6),
              blurRadius: 15,
            ),
            Shadow(
              color: AppColors.balck3,
              offset: const Offset(9, 9),
              blurRadius: 20,
            ),
          ],
        );

      case TextStyleType.subtitle:
        return GoogleFonts.abel(
          fontSize: 24.sp,
          color: AppColors.white,
          fontWeight: FontWeight.w500,
          shadows: [
            Shadow(
              color: AppColors.balck2,
              offset: const Offset(2, 2),
              blurRadius: 6,
            ),
          ],
        );

      case TextStyleType.body:
        return GoogleFonts.abel(
          fontSize: 18.sp,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        );

      case TextStyleType.caption:
        return GoogleFonts.abel(
          fontSize: 14.sp,
          color: AppColors.grey,
          fontWeight: FontWeight.w400,
        );

      case TextStyleType.label:
        return GoogleFonts.abel(
          fontSize: 12.sp,
          color: AppColors.black54,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        );

      case TextStyleType.custom:
        return customStyle ?? const TextStyle();
    }
  }
}
