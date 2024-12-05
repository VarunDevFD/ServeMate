// state.dart
import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/theme/app_colors.dart';

class DressFormState {
  final String selectedGender;
  final String selectedDressType;
  final String selectedDressModel;
  final String selectedCondition;
  final String selectedSize;
  final Color selectedColor;
  final String colorName;
  final String rentalDuration;
  final double securityDeposit;
  final String damagePolicy;
  final DateTimeRange? selectedDateRange;

  DressFormState({
    this.selectedGender = 'Men',
    this.selectedDressType = '',
    this.selectedDressModel = '',
    this.selectedCondition = '',
    this.selectedSize = '',
    this.selectedColor = AppColors.white,
    this.colorName = 'White',
    this.rentalDuration = '',
    this.securityDeposit = 0.0,
    this.damagePolicy = '',
    this.selectedDateRange,
  });

  DressFormState copyWith({
    String? selectedGender,
    String? selectedDressType,
    String? selectedDressModel,
    String? selectedCondition,
    String? selectedSize,
    Color? selectedColor,
    String? colorName,
    String? rentalDuration,
    double? securityDeposit,
    String? damagePolicy,
    DateTimeRange? selectedDateRange,
  }) {
    return DressFormState(
      selectedGender: selectedGender ?? this.selectedGender,
      selectedDressType: selectedDressType ?? this.selectedDressType,
      selectedDressModel: selectedDressModel ?? this.selectedDressModel,
      selectedCondition: selectedCondition ?? this.selectedCondition,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      colorName: colorName ?? this.colorName,
      rentalDuration:
          rentalDuration ?? this.rentalDuration,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      damagePolicy: damagePolicy ?? this.damagePolicy,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
    );
  }
}
