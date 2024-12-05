import 'package:flutter_bloc/flutter_bloc.dart';
import 'dropdown_event.dart';
import 'dropdown_state.dart';

class DropdownBloc<T> extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(DropdownInitialState()) {
    on<DropdownValueChangedEvent>((event, emit) {
      emit(DropdownValueChangedState(event.selectedValue));
    });
  }
}
