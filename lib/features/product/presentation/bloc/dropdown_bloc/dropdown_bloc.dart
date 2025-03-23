import 'package:flutter_bloc/flutter_bloc.dart';
import 'dropdown_event.dart';
import 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(DropdownInitial()) {
    on<DropdownValueChangedEvent>(_onDropdownValueChanged);
  }

  void _onDropdownValueChanged(
    DropdownValueChangedEvent event,
    Emitter<DropdownState> emit,
  ) {
    if (event.value.isNotEmpty) {
      emit(DropdownSelected(selectedValue: event.value));
    }
  }
}
