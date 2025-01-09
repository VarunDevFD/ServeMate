part of 'temp_bloc.dart';

abstract class FormEvent {}

class TextFieldChanged extends FormEvent {
  final String fieldName;
  final String fieldValue;

  TextFieldChanged(this.fieldName, this.fieldValue);
}

class ValidateForm extends FormEvent {}

class ResetForm extends FormEvent {}
