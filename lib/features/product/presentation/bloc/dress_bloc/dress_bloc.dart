import 'package:bloc/bloc.dart';
import 'dress_event.dart';
import 'dress_state.dart';


class DressFormBloc extends Bloc<DressFormEvent, DressFormState> {
  DressFormBloc() : super(DressFormState()) {
    on<GenderSelected>((event, emit) {
      emit(state.copyWith(selectedGender: event.gender));
    });

    on<DressTypeChanged>((event, emit) {
      emit(state.copyWith(selectedDressType: event.dressType));
    });

    on<SizeChanged>((event, emit) {
      emit(state.copyWith(selectedSize: event.size));
    });
  }
}
