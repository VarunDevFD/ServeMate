// state.dart
import 'package:flutter/material.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

class DressFormState {
  final String selectedGender;  
  final Color selectedColor;
  final String colorName;  
  final DateTimeRange? selectedDateRange;

  DressFormState({
    this.selectedGender = 'Men',  
    this.selectedColor = AppColors.white,
    this.colorName = "Choose the Color",  
    this.selectedDateRange,
  });

  DressFormState copyWith({
    String? selectedGender, 
    Color? selectedColor,
    String? colorName,  
    DateTimeRange? selectedDateRange,
  }) {
    return DressFormState(
      selectedGender: selectedGender ?? this.selectedGender,  
      selectedColor: selectedColor ?? this.selectedColor,
      colorName: colorName ?? this.colorName,  
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
    );
  }
}
