import 'model.dart';

abstract class FormEvent {}

class FormFieldChanged extends FormEvent {
  final FormModel updatedFormModel;

  FormFieldChanged(this.updatedFormModel);
}

class FormSubmitEvent extends FormEvent {}

class ResetFormEvent extends FormEvent {}
