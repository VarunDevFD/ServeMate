abstract class DropdownEvent {}

class DropdownValueChangedEvent extends DropdownEvent {
  final String selectedValue;

  DropdownValueChangedEvent(this.selectedValue);
}
