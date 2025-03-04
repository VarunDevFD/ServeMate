import 'package:flutter_bloc/flutter_bloc.dart';
import 'temp_event.dart';
import 'temp_state.dart';

class FormTempBloc extends Bloc<FormEvent, FormTempState> {
  FormTempBloc() : super(FormInitialState()) {
    on<FormFieldChanged>((event, emit) async {
      emit(FormAddingState());
      try {
        emit(FormSuccessState("Success"));
      } catch (e) {
        emit(FormFailureState('Failed to add product'));
      }
    });
  }
}
