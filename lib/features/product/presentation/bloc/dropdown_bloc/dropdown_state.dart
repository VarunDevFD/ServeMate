abstract class DropdownState {}

class DropdownInitialState extends DropdownState {}

class DropdownValueChangedState extends DropdownState {
  final String selectedValue;

  DropdownValueChangedState(this.selectedValue);
}
