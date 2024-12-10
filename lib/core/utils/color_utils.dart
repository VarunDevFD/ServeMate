import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/color_contants.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

int hexToColor(String colorNameOrHex) {
  if (colorNameToHex.containsKey(colorNameOrHex)) {
    colorNameOrHex = colorNameToHex[colorNameOrHex]!;
  } else {
    colorNameOrHex = colorNameToHex['Custom Color']!;
  }

  if (colorNameOrHex.startsWith('#')) {
    colorNameOrHex = colorNameOrHex.substring(1);
  }

  return int.parse(colorNameOrHex, radix: 16) + 0xFF000000;
}

String getColorRange(int argb) {
  int r = (argb >> 16) & 0xFF;
  int g = (argb >> 8) & 0xFF;
  int b = argb & 0xFF;

  if (r > 200 && g < 100 && b < 100) return 'Red';
  if (r > 200 && g > 100 && g < 200 && b < 100) return 'Orange';
  if (r > 200 && g > 200 && b < 100) return 'Yellow';
  if (r < 100 && g > 200 && b < 100) return 'Green';
  if (r < 100 && g < 100 && b > 200) return 'Blue';
  if (r > 100 && r < 200 && g < 100 && b > 200) return 'Purple';
  if (r > 200 && g < 100 && b > 150) return 'Pink';
  if (r < 100 && g > 200 && b > 200) return 'Cyan';
  if (r < 100 && g < 100 && b < 100) return 'Black';
  if (r > 200 && g > 200 && b > 200) return 'White';
  if (r > 150 && g > 150 && b > 150) return 'Light Gray';
  if (r < 150 && g < 150 && b < 150) return 'Dark Gray';
  return 'Custom Color';
}

Color? getColorByName(String colorName) {
  // Add a list or map of color names to Color values
  Map<String, Color> colorMap = {
    'red': AppColors.red,
    'blue': AppColors.blue,
    'green': AppColors.green,
    'orange': AppColors.orange,
    'yellow': AppColors.yellow,
    'purple': AppColors.purple,
    'pink': AppColors.pink,
    'cyan': AppColors.cyan,
    'black': AppColors.black,
    'white': AppColors.white,
    'gray': AppColors.grey,
  };

  return colorMap[colorName
      .toLowerCase()]; // Return the matched color, or null if not found
}
