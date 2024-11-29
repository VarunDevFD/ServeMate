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

class DressModelChanged extends DressFormEvent {
  final String dressModel;

  DressModelChanged(this.dressModel);
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


class RentalDurationChanged extends DressFormEvent {
  final String duration;
  RentalDurationChanged(this.duration);
}

class SecurityDepositChanged extends DressFormEvent {
  final double deposit;
  SecurityDepositChanged(this.deposit);
}

class DamagePolicyChanged extends DressFormEvent {
  final String policy;
  DamagePolicyChanged(this.policy);
}

class DateRangeSelected extends DressFormEvent {
  final DateTimeRange dateRange;
  DateRangeSelected(this.dateRange);
}