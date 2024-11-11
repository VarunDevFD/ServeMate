// state.dart
import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/theme/app_colors.dart';

class DressFormState {

  final String selectedGender;
  final String selectedDressType;
  final String selectedCondition;
  final String selectedSize;
  final Color selectedColor;
  final String colorName;

  DressFormState({
    this.selectedGender = '',
    this.selectedDressType = '',
    this.selectedCondition = '',
    this.selectedSize = '',
    this.selectedColor = AppColors.white,
    this.colorName = 'White',
  });

  DressFormState copyWith({
    String? selectedGender,
    String? selectedDressType,
    String? selectedCondition,
    String? selectedSize,
    Color? selectedColor,
    String? colorName,
  }) {
    return DressFormState(
      selectedGender: selectedGender ?? this.selectedGender,
      selectedDressType: selectedDressType ?? this.selectedDressType,
      selectedCondition: selectedCondition ?? this.selectedCondition,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      colorName: colorName ?? this.colorName,
    );
  }
}
