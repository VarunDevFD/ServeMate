import 'package:flutter/material.dart';

abstract class DressFormEvent {}

class GenderSelected extends DressFormEvent {
  final String gender;

  GenderSelected(this.gender);
} 

class ColorChanged extends DressFormEvent {
  final Color color;
  final String colorName;
  ColorChanged(this.color, this.colorName);
} 

class DateRangeSelected extends DressFormEvent {
  final DateTimeRange dateRange;
  DateRangeSelected(this.dateRange);
}