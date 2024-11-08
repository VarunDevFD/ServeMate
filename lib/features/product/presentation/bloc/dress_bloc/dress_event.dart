// events.dart
import 'package:flutter/material.dart';

abstract class DressFormEvent {}

class GenderSelected extends DressFormEvent {
  final String gender;

  GenderSelected(this.gender);
}

class DressTypeChanged extends DressFormEvent {
  final String dressType;

  DressTypeChanged(this.dressType);
}

class SizeChanged extends DressFormEvent {
  final String size;

  SizeChanged(this.size);
}

class ColorChanged extends DressFormEvent {
  final Color color;
  final String colorName;
  ColorChanged(this.color, this.colorName);
}

class DressConditionChanged extends DressFormEvent {
  final String condition;

  DressConditionChanged(this.condition);
}


class CurrentLocation extends DressFormEvent {}