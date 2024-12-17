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
  static Color backgroundColor = const Color(0xFFEDF4F5);
  static Color dimBlack = const Color.fromARGB(255, 213, 212, 212);

  // Error
  static const Color error = Color.fromARGB(255, 240, 13, 13);

  //------------------Shade-----------------------------------------------------
  // Black
  static Color balck1 = Colors.black.withOpacity(0.6);
  static Color balck2 = Colors.black.withOpacity(0.4);
  static Color balck3 = Colors.black.withOpacity(0.2);
  static Color balck4 = Colors.black.withOpacity(0.5);

  // White
  static Color white1 = Colors.white.withOpacity(0.2);

  // Orange
  static Color orange1 = const Color.fromARGB(255, 239, 145, 74);
  static Color orange2 = const Color(0xFFFCD9A3);
  static Color orange3 = const Color.fromARGB(255, 255, 111, 0);
  static Color orange4 = const Color.fromARGB(199, 224, 105, 19);

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
}
