// lib/features/auth/presentation/bloc/toggle_bloc/toggle_bloc_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'toggle_bloc_event.dart';
import 'toggle_bloc_state.dart';

class TogglePasswordBloc extends Bloc<TogglePasswordEvent, TogglePasswordState> {
  TogglePasswordBloc() : super(const TogglePasswordState(passwordVisible: false, confirmPasswordVisible: false)) {
    on<TogglePasswordVisibility>(_onTogglePassword);
    on<ToggleConfirmPasswordVisibility>(_onToggleConfirmPassword);
  }

  void _onTogglePassword(TogglePasswordVisibility event, Emitter<TogglePasswordState> emit) {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  void _onToggleConfirmPassword(ToggleConfirmPasswordVisibility event, Emitter<TogglePasswordState> emit) {
    emit(state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible));
  }
}
