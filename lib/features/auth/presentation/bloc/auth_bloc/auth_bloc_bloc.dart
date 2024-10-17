import 'dart:developer';

import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/auth/domain/repositories/auth_repo.dart';
import 'package:serve_mate/features/auth/domain/usecases/auth_user.dart';
import 'package:serve_mate/features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'package:serve_mate/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:serve_mate/features/auth/domain/usecases/sign_out.dart';
import 'package:serve_mate/features/auth/domain/usecases/sign_up_with_email_password.dart';
import 'package:serve_mate/features/auth/presentation/bloc/auth_bloc/auth_bloc_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  final SignInWithGoogle googleSignIn;
  final SignOut googleSignOut;

  AuthBloc({required this.googleSignIn, required this.googleSignOut}) : super(AuthInitial()) {
    //------------------------------SignInEvent---------------------------------

    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      final signIn = serviceLocator<SignInWithEmailPassword>();
      final getCurrentUser = serviceLocator<GetCurrentUser>();
      try {
        await signIn(event.email, event.password);
        final user = getCurrentUser(); // Fetch the current authenticated user
        await _setHasSeenHome(); // Call to save flag in SharedPreferences
        emit(Authenticated(user!));
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    //------------------------------SignUpEvent---------------------------------
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final signUp = serviceLocator<SignUpWithEmailPassword>();
      final getCurrentUser = serviceLocator<GetCurrentUser>();
      try {
        // Call the sign-up method
        await signUp(event.email, event.password);

        // Fetch the current authenticated user
        final user = getCurrentUser();

        if (user != null) {
          await _setHasSeenHome(); // Call to save flag in SharedPreferences
          emit(Authenticated(user)); // Emit Authenticated state with User
        } else {
          emit(const AuthError('Sign up failed. Please try again.'));
        }
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    //----------------------GoogleSignInEvent-----------------------------------
    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await googleSignIn(); // Call the sign-in method
        log(user.toString());
        if (user != null) {
          emit(Authenticated(user)); // Emit Authenticated state
          await _setHasSeenHome(); // Call to save flag in SharedPreferences
        } else {
          emit(const AuthError('Google sign-in failed')); // Emit error state
        }
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    //----------------------Sign-Out--------------------------------------------
    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final repo = serviceLocator<AuthRepository>();
        await repo.signOut(); // Call sign out method from use case
        await repo.clearAuthUser(); // Clears the local auth token
        emit(Unauthenticated()); // Emit Unauthenticated state
        // Clear the user's session from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('hasSeenHome'); // Optionally, remove the home flag
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state if sign-out fails
      }
    });
  }

  // Helper function to set hasSeenHome flag in SharedPreferences
  Future<void> _setHasSeenHome() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenHome', true); // Save the flag
  }
}
