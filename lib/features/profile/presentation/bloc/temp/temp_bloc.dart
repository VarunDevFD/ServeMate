import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'temp_event.dart';
part 'temp_state.dart';

class FormBloc extends Bloc<FormEvent, MyFormState> {
  FormBloc() : super(MyFormState.initial()) {
    on<TextFieldChanged>(_onTextFieldChanged);
    on<ValidateForm>(_onValidateForm);
    on<ResetForm>(_onResetForm); // Make sure this exists
  }

  void _onTextFieldChanged(TextFieldChanged event, Emitter<MyFormState> emit) {
    final updatedFields = Map<String, String>.from(state.fields)
      ..[event.fieldName] = event.fieldValue;

    emit(state.copyWith(
      fields: updatedFields,
      isValid: _validateAllFields(updatedFields),
    ));
    log("-----------------");
    log(updatedFields.toString());
    log("-----------------");
  }

  void _onValidateForm(ValidateForm event, Emitter<MyFormState> emit) {
    emit(state.copyWith(isValid: _validateAllFields(state.fields)));
    log("---------------------------*----------------------------------------");
    log(event.toString());
    log("---------------------------*----------------------------------------");

  }

  void _onResetForm(ResetForm event, Emitter<MyFormState> emit) {
    emit(MyFormState.initial()); 
  }

  bool _validateAllFields(Map<String, String> fields) {
    return fields.values.every((value) => value.isNotEmpty);
  }
}
