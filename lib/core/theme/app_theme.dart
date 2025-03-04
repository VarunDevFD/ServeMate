import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

class AppTheme {
  // Custom Theme Data
  static ThemeData buildWeddingTheme() {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      cardTheme: const CardTheme(
        color: AppColors.cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        prefixIconColor: AppColors.primary,
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return Colors.grey;
        }),
        trackColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) return AppColors.secondary;
          return Colors.grey.shade300;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return Colors.grey;
        }),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
  // static final darkThemeMode = ThemeData.dark();
  // static _border([Color color = AppColors.grey]) => OutlineInputBorder(
  //       borderSide: BorderSide(
  //         color: color,
  //       ),
  //       borderRadius: BorderRadius.circular(8.r),
  //     );
  // static final lightThemeMode = ThemeData.light().copyWith(
  //     elevatedButtonTheme: ElevatedButtonThemeData(
  //       style: ButtonStyle(
  //         fixedSize: WidgetStatePropertyAll(Size(450.w, 40.h)),
  //         backgroundColor: WidgetStatePropertyAll(AppColors.orange),
  //         foregroundColor: WidgetStatePropertyAll(AppColors.black),
  //       ),
  //     ),
  //     scaffoldBackgroundColor: AppColors.white,
  //     inputDecorationTheme: InputDecorationTheme(
  //       contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
  //       enabledBorder: _border(),
  //       focusedBorder: _border(AppColors.orange),
  //       errorBorder: _border(AppColors.red),
  //       focusedErrorBorder:
  //           _border(AppColors.redAccent),
  //       errorStyle: TextStyle(
  //         color: AppColors.red,
  //         fontSize: 12.sp,
  //       ),
  //       hintStyle: TextStyle(
  //         color: AppColors.grey.withOpacity(0.6),
  //         fontSize: 12.sp,
  //       ),
  //       labelStyle: GoogleFonts.sora(
  //         color: AppColors.balck1,
  //         fontSize: 13.sp,
  //         fontWeight: FontWeight.w600,
  //       ),
  //       floatingLabelStyle: TextStyle(
  //         color: AppColors.orange3,
  //       ),
  //       floatingLabelBehavior: FloatingLabelBehavior.auto,
  //     ));
}
