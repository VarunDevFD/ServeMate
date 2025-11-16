import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/constants.dart';

class TextFieldHelper {
  static int getMaxLengthForLabel(String label) {
    switch (label) {
      case Names.name:
        return 20;
      case Names.price:
      case Names.securityDeposit:
      case Names.capacity:
        return 6;
      case Names.seatCapacity:
        return 2;
      case Names.duration:
      case Names.quantity:
        return 2;
      case Names.phoneNumber:
        return 10;
      case Names.description:
        return 20;
      default:
        return 100;
    }
  }

  static TextInputType getKeyboardTypeForLabel(String label) {
    switch (label) {
      case Names.price:
      case Names.securityDeposit:
      case Names.capacity:
      case Names.seatCapacity:
      case Names.duration:
      case Names.quantity:
        return TextInputType.number;
      case Names.phoneNumber:
        return TextInputType.phone;
      default:
        return TextInputType.text;
    }
  }
}
