import 'package:flutter/material.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark();
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.white,
  );
}
