import 'package:bloc/bloc.dart';
import 'item_event.dart';
import 'item_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  CommonBloc() : super(InitialState()) {
    on<GenderChanged>(genderChanged);
  }

  void genderChanged(GenderChanged event, Emitter<CommonState> emit) {
    emit(LoadingState());
    try {
      emit(SuccessState(event.type));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}

 