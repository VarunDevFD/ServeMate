import 'package:flutter_bloc/flutter_bloc.dart';

import 'dress_event.dart';
import 'dress_state.dart';

class DressFormBloc extends Bloc<DressFormEvent, DressFormState> {
  DressFormBloc() : super(DressFormState()) {
    // Gender
    on<GenderSelected>((event, emit) {
      emit(
        state.copyWith(selectedGender: event.gender),
      );
    });

    // Color
    on<ColorChanged>((event, emit) {
      emit(
        state.copyWith(selectedColor: event.color, colorName: event.colorName),
      );
    });
  }
}
