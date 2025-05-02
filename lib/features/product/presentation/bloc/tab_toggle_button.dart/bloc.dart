import 'package:bloc/bloc.dart';

class CheckBoxCubit extends Cubit<bool> {
  CheckBoxCubit() : super(false);
  void checkeBoxAvailable(bool value) => emit(value);

  void reset() => emit(false);

   
}
