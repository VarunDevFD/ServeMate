abstract class FormTempState{}

class FormInitialState extends FormTempState {}

class FormAddingState extends FormTempState {}

class FormSuccessState extends FormTempState {
  final String successMessage;
  FormSuccessState(this.successMessage);
}

class FormFailureState extends FormTempState {
  final String errorMessage;
  FormFailureState(this.errorMessage);
}

class FormValidationState extends FormTempState {
  final Map<String, String> validationErrors;
  FormValidationState(this.validationErrors);
}


