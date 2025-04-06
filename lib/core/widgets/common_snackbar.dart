import 'package:flutter/material.dart';

class AppSnackBar {
  static void show(
    BuildContext context, {
    required String content,
    Duration duration = const Duration(seconds: 2),
    Color backgroundColor = Colors.grey,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: duration,
        backgroundColor: backgroundColor,
      ),
    );
  }
}