import 'package:bloc/bloc.dart';

class AvailableSwitchCubit extends Cubit<bool> {
  AvailableSwitchCubit() : super(false);

  void toggleAvailable(bool value) => emit(value);
}
