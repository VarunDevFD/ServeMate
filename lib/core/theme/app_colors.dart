import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Colors.white;
  static Color black = Colors.black;
  static Color yellow = Colors.yellow;
  static Color green = Colors.green;
  static Color purple = Colors.purple;
  static Color pink = Colors.pink;
  static Color cyan = Colors.cyan;
  static Color orange = Colors.orange;
  static const Color grey = Colors.grey;
  static Color red = Colors.red;
  static Color blue = Colors.blue;
  static Color transparent = Colors.transparent;
  static Color primary = const Color(0xFFD59C71);
  static const Color secondary = Color(0xFFFFE0B2);
  static const Color textPrimary = Color(0xFF424242);
  static const Color textSecondary = Color(0xFF757575);
  static Color background = const Color(0xFFEDF4F5);
  static Color dimBlack = const Color.fromARGB(255, 213, 212, 212);
  static Color dimOrange = const Color.fromARGB(255, 255, 248, 244);
  static Color dimGreen = const Color.fromARGB(255, 244, 255, 244);
  static const Color cardBackground = Color(0xFFFFFBFA);
  static const Color border = Color(0xFFEEEEEE);
  static const Color imageBr = Color(0xFFEEEEEE);
  static const Color purpleAccent = Colors.purpleAccent;
  static const Color pinkAccent = Colors.pinkAccent;

  // Error
  static const Color error = Color.fromARGB(255, 240, 13, 13);

  //------------------Shade-----------------------------------------------------
  // Black
  static Color balck1 = Colors.black.withAlpha((0.6 * 255).toInt());
  static Color balck2 = Colors.black.withAlpha((0.4 * 255).toInt());
  static Color balck3 = Colors.black.withAlpha((0.2 * 255).toInt());
  static Color balck4 = Colors.black.withAlpha((0.5 * 255).toInt());

  // White
  static Color white0 =
      const Color.fromARGB(255, 255, 237, 237).withAlpha((0.2 * 255).toInt());
  static Color white1 = Colors.white.withAlpha((0.2 * 255).toInt());
  static Color white2 =
      const Color.fromARGB(255, 255, 188, 149).withAlpha((0.2 * 255).toInt());

  // Orange
  static Color orange1 = const Color.fromARGB(255, 239, 145, 74);
  static Color orange2 = const Color(0xFFFCD9A3);
  static Color orange3 = const Color.fromARGB(255, 255, 111, 0);
  static Color orange4 = const Color.fromARGB(199, 224, 105, 19);
  static Color orange5 = const Color.fromARGB(175, 255, 116, 17);

  // Red
  static Color redAccent = Colors.redAccent;

  // Blue
  static Color blueAccent = Colors.blueAccent;

  // Blue
  static Color greenLight = Colors.greenAccent;

  //-----------------Black-Opacity----------------------------------------------
  static const Color black54 = Colors.black54;

  //-----------------Gradiant---------------------------------------------------

  static const Color gradient1 = Color.fromRGBO(246, 159, 39, 1);
  static const Color gradient2 = Color.fromRGBO(228, 131, 70, 1);
  static const Color gradient3 = Color.fromRGBO(255, 153, 116, 1);

  static Color geryOp5 = Colors.grey.withOpacity(0.5);
}
