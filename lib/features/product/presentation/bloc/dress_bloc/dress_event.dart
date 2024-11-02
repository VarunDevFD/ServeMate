// events.dart
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
