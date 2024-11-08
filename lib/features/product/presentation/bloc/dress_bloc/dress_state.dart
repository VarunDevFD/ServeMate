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
  final String? currentLocation;
  final bool isFetchingLocation;
  final String? locationError;

  DressFormState({
    this.selectedGender = '',
    this.selectedDressType = '',
    this.selectedCondition = '',
    this.selectedSize = '',
    this.selectedColor = AppColors.white,
    this.colorName = 'White',
    this.currentLocation,
    this.isFetchingLocation = false,
    this.locationError,
  });

  DressFormState copyWith({
    String? selectedGender,
    String? selectedDressType,
    String? selectedCondition,
    String? selectedSize,
    Color? selectedColor,
    String? colorName,
    String? currentLocation,
    bool? isFetchingLocation,
    String? locationError,
  }) {
    return DressFormState(
      selectedGender: selectedGender ?? this.selectedGender,
      selectedDressType: selectedDressType ?? this.selectedDressType,
      selectedCondition: selectedCondition ?? this.selectedCondition,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      colorName: colorName ?? this.colorName,
      currentLocation: currentLocation ?? this.currentLocation,
      isFetchingLocation: isFetchingLocation ?? this.isFetchingLocation,
      locationError: locationError ?? this.locationError,
    );
  }
}
