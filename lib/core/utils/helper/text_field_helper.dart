import 'package:flutter/material.dart';

class TextFieldHelper {
  static int getMaxLengthForLabel(String label) {
    switch (label) {
      case 'Name':
        return 20;
      case 'Price':
      case 'Security Deposit':
      case 'Capacity':
        return 6;
      case 'Phone Number':
        return 10;
      default:
        return 100;
    }
  }

  static TextInputType getKeyboardTypeForLabel(String label) {
    switch (label) {
      case 'Price':
      case 'Security Deposit':
      case 'Capacity':
        return TextInputType.number;
      case 'Phone Number':
        return TextInputType.phone;
      default:
        return TextInputType.text;
    }
  }
}
