// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class DropdownState {}

class DropdownInitial extends DropdownState {}

class DropdownSelected extends DropdownState {
  final String selectedValue;
  
  DropdownSelected({required this.selectedValue});
}
