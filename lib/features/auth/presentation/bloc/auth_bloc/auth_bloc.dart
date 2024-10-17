import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/services/injection_container.dart';
import 'package:serve_mate/features/auth/domain/usecases/auth_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailPassword signInUseCase = serviceProvider();
  final RegisterWithEmailPassword registerUseCase = serviceProvider();

  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>(_onSignInRequested);
    on<RegisterEvent>(_onRegisterRequested);
  }

  Future<void> _onSignInRequested(
      SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signInUseCase(event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase(event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
