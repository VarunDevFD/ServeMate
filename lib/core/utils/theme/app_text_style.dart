import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart'; // Import your app colors

class AppTextStyles {
  static TextStyle titleStyle = GoogleFonts.sora(
    color: AppColors.primary,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subTitleStyle = GoogleFonts.sora(
    color: AppColors.primary,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static TextStyle buttonTextStyle = GoogleFonts.sora(
    color: AppColors.primary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle customButtonTextStyle = GoogleFonts.sora(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );

  static TextStyle customButtonTextStyleSignIn = GoogleFonts.sora(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );

  static TextStyle buttonTextStyleForgotBn = GoogleFonts.sora(
    color: AppColors.primary,
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );

  static TextStyle buttonTextStyleWelcomeBn2 = GoogleFonts.sora(
    color: AppColors.primary,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );

  static TextStyle titleSignIn = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}
