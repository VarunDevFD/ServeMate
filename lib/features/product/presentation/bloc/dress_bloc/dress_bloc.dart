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

    // Dress type 
    on<DressTypeChanged>((event, emit) {
      emit(
        state.copyWith(selectedDressType: event.dressType),
      );
    });

    // Dress Model 
    on<DressModelChanged>((event, emit) {
      emit(
        state.copyWith(selectedDressModel: event.dressModel),
      );
    });

    // Condition 
    on<DressConditionChanged>((event, emit) {
      emit(
        state.copyWith(selectedCondition: event.condition),
      );
    });

    // Size 
    on<SizeChanged>((event, emit) {
      emit(
        state.copyWith(selectedSize: event.size),
      );
    });

    // Color 
    on<ColorChanged>((event, emit) {
      emit(
        state.copyWith(selectedColor: event.color, colorName: event.colorName),
      );
    });

    // Rental Duration 
    on<RentalDurationChanged>((event, emit) {
      emit(state.copyWith(rentalDuration: event.duration));
    });

    // Security Deposit 
    on<SecurityDepositChanged>((event, emit) {
      emit(state.copyWith(securityDeposit: event.deposit));
    });

    // Damage Policy 
    on<DamagePolicyChanged>((event, emit) {
      emit(state.copyWith(damagePolicy: event.policy));
    });
  }
}
