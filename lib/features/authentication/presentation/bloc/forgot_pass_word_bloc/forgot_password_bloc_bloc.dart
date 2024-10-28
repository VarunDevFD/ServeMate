import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/error/failure.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_event.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordInitial()) {
    on<ForgetPasswordEvent>(_onForgetPassword);
  }

  void _onForgetPassword(
    ForgetPasswordEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    // Emit loading state when the process starts
    emit(ForgetPasswordLoadingState());

    try {
      final firebaseAuth = serviceLocator<FirebaseAuth>();
      // Send the password reset email using Firebase Auth
      await firebaseAuth.sendPasswordResetEmail(email: event.email);

      // Emit success state when the password reset email is successfully sent
      emit(ForgetPasswordSuccessState());
    } on FirebaseAuthException catch (e) {
      // Convert FirebaseAuthException to Failure
      final failure =
          Failure(message: e.message ?? 'An unknown error occurred');

      // Emit failure state with the converted Failure object
      emit(ForgetPasswordFailState(error: failure));
    } catch (e) {
      // Handle any other unknown exceptions by converting them into a Failure
      const failure =
          Failure(message: 'An unknown error occurred. Please try again.');

      // Emit fail state for unknown errors
      emit(ForgetPasswordFailState(error: failure));
    }
  }

  
}
