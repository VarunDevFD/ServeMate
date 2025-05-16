import 'package:bloc/bloc.dart';
import 'item_event.dart';
import 'item_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  CommonBloc() : super(InitialState()) {
    on<GenderChanged>(genderChanged);
    on<AccessSwitch>(accessSwitch);
  }

  void genderChanged(GenderChanged event, Emitter<CommonState> emit) {
    emit(LoadingState());
    try {
      emit(SuccessState(event.type));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void accessSwitch(AccessSwitch event, Emitter<CommonState> emit) {
    try {
      final currentState = state;
      bool newBtnValue = true;

      if (currentState is AccessState) {
        newBtnValue = !currentState.btn;
      }

      emit(AccessState(newBtnValue));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
