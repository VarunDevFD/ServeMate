import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark();
  static _border([Color color = AppColors.grey]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
        ),
        borderRadius: BorderRadius.circular(8.r),
      );
  static final lightThemeMode = ThemeData.light().copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(Size(450.w, 40.h)),
          backgroundColor: WidgetStatePropertyAll(AppColors.orange),
          foregroundColor: WidgetStatePropertyAll(AppColors.black),
        ),
      ),
      scaffoldBackgroundColor: AppColors.white,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        enabledBorder: _border(),
        focusedBorder: _border(AppColors.orange),
        errorBorder: _border(AppColors.red),
        focusedErrorBorder:
            _border(AppColors.redAccent), 
        errorStyle: TextStyle(
          color: AppColors.red,
          fontSize: 12.sp, 
        ),
        hintStyle: TextStyle(
          color: AppColors.grey.withOpacity(0.6),
          fontSize: 12.sp, 
        ),
        labelStyle: GoogleFonts.sora(
          color: AppColors.balck1,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
        floatingLabelStyle: TextStyle(
          color: AppColors.orange3, 
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ));
}
