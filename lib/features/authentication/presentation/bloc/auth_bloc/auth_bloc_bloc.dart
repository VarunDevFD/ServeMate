import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_in_with_email_password.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_state.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_in_with_google.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_up_with_email_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  final PreferencesRepository pref = serviceLocator<PreferencesRepository>();

  AuthBloc() : super(AuthInitial()) {
    //------------------------------SignInEvent---------------------------------
    on<SignInEvent>((event, emit) async {
      emit(AuthInitial());
      final signIn = serviceLocator<SignInEmailPasswordUseCase>();

      try {
        final response = await signIn(event.email, event.password, event.role);
        if (response) {
          // Check if sign-in was successful and user data is available
          emit(const Authenticated(true));
        } else {
          emit(const AuthError("Email not Found try again the Email"));
        }
      } catch (e) {
        emit(AuthError(e.toString())); // Display the role validation error
      }
    });

    //------------------------------SignUpEvent---------------------------------
    on<SignUpEvent>((event, emit) async {
      emit(AuthInitial());
      final signUp = serviceLocator<SignUpWithEmailPassword>();

      try {
        await signUp.call(event.name, event.email, event.password);
        emit(const Authenticated(true));
      } catch (e) {
        // Handle general errors
        emit(AuthError("An unexpected error occurred: $e"));
      }
    });

    //----------------------GoogleSignInEvent-----------------------------------
    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthInitial());
      final signInWithGoogle = serviceLocator<SignInWithGoogle>();

      try {
        final User? user = await signInWithGoogle(); // Ensure this is awaited

        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(const AuthError('Google sign-in failed'));
        }
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state
      }
    });

    //----------------------Sign-Out--------------------------------------------
    on<SignOutEvent>((event, emit) async {
      emit(AuthInitial());
      try {
        final repo = serviceLocator<AuthRepository>();
        await repo.signOut(); // Call sign out method from use case
        await repo.clearAuthUser(); // Clears the local auth token
        emit(Unauthenticated()); // Emit Unauthenticated state
        await _clearHasSeenHome(); // Clear the user's session flag
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state if sign-out fails
      }
    });
  }
  
  

  // Helper function to clear the hasSeenHome flag
  Future<void> _clearHasSeenHome() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('hasSeenHome'); // Remove the home flag
  }
}
