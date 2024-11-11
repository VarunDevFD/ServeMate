import 'package:flutter_bloc/flutter_bloc.dart';

import 'dress_event.dart';
import 'dress_state.dart';

class DressFormBloc extends Bloc<DressFormEvent, DressFormState> {
  DressFormBloc() : super(DressFormState()) {
    // Gender selection logic
    on<GenderSelected>((event, emit) {
      emit(
        state.copyWith(selectedGender: event.gender),
      );
    });

    // Dress type change logic
    on<DressTypeChanged>((event, emit) {
      emit(
        state.copyWith(selectedDressType: event.dressType),
      );
    });

    // Condition change logic
    on<DressConditionChanged>((event, emit) {
      emit(
        state.copyWith(selectedCondition: event.condition),
      );
    });

    // Size change logic
    on<SizeChanged>((event, emit) {
      emit(
        state.copyWith(selectedSize: event.size),
      );
    });

    // Color change logic
    on<ColorChanged>((event, emit) {
      emit(
        state.copyWith(selectedColor: event.color, colorName: event.colorName),
      );
    });
  }
}
