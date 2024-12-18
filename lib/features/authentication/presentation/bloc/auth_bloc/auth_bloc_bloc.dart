import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_state.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';
import 'package:serve_mate/features/authentication/domain/usecases/auth_user.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_in_with_email_password.dart';
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
      final signIn = serviceLocator<SignInWithEmailPassword>();
      final getCurrentUser = serviceLocator<GetCurrentUser>();

      try {
        // Perform sign-in
        await signIn(event.email, event.password);

        // Fetch the currently signed-in user
        final currentUser = getCurrentUser();
        if (currentUser != null) {
          emit(Authenticated(currentUser));
        } else {
          emit(const AuthError(
              "Login succeeded, but failed to fetch user data."));
        }
      } on Exception catch (e) {
        emit(AuthError(e.toString())); // Display the role validation error
      }
    });

    //------------------------------SignUpEvent---------------------------------
    on<SignUpEvent>((event, emit) async {
      emit(AuthInitial());
      final signUp = serviceLocator<SignUpWithEmailPassword>();

      try {
        // Perform the sign-up operation
        await signUp(event.name, event.email, event.password);

        // Get the current user after sign-up
        final currentUser = serviceLocator<AuthRepository>().getCurrentUser();

        // Ensure the currentUser is not null before emitting
        if (currentUser != null) {
          emit(Authenticated(
              currentUser)); // Pass the user to the Authenticated state
        } else {
          emit(const AuthError(
              "Sign-up succeeded, but failed to fetch user data."));
        }
      } on FirebaseAuthException catch (e) {
        // Handle Firebase-specific errors
        String errorMessage;
        switch (e.code) {
          case 'weak-password':
            errorMessage =
                "The password is too weak. Please use at least 6 characters.";
            break;
          case 'email-already-in-use':
            errorMessage =
                "This email is already registered. Please try logging in.";
            break;
          case 'invalid-email':
            errorMessage =
                "The email address is not valid. Please provide a valid email.";
            break;
          default:
            errorMessage = "An unexpected error occurred: ${e.message}";
        }
        emit(AuthError(errorMessage));
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

  // Helper function to set hasSeenHome flag in SharedPreferences
  Future<void> _setHasSeenCategoryPage(bool value, BuildContext context) async {
    await pref.setHasSeenOnboarding(value).then((_) {
      context.go('/selectCategory'); // Use context after async call completes
    });
  }

  // Helper function to clear the hasSeenHome flag
  Future<void> _clearHasSeenHome() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('hasSeenHome'); // Remove the home flag
  }
}
