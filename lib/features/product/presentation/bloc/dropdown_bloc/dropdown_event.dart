abstract class DropdownEvent {}

class DropdownValueChangedEvent extends DropdownEvent {
  final String value;

  DropdownValueChangedEvent(this.value);
}

class ResetDropdown extends DropdownEvent {}
