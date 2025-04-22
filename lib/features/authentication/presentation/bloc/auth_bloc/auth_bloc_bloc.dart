import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/features/authentication/data/models/user_model.dart';
import 'package:serve_mate/features/authentication/domain/entities/user_entity.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_in_with_email_password.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_in_with_google.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_up_with_email_password.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_event.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  final PreferencesRepository pref = serviceLocator<PreferencesRepository>();

  AuthBloc() : super(AuthInitial()) {
    // Initialize the Data All
    on<CheckAuthStatusEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final firebaseAuth = serviceLocator<FirebaseAuth>();
        final user = firebaseAuth.currentUser;

        if (user != null) {
          // Check SharedPreferences first
          final uid = await pref.getUserId();
          final name = await pref.getName();
          final email = await pref.getEmail();
          final photoUrl = await pref.getPhotoUrl();
          final googleSignIn = await pref.getSignIn();

          if (uid != null && name != null && email != null) {
            // Use data from SharedPreferences
            final authUserModel = UserModel(
              id: uid,
              name: name,
              email: email,
              photoUrl: photoUrl,
              googleSignIn: googleSignIn,
              createdAt: DateTime.now(),
              role: 'User',
            );
            emit(Authenticated(authUserModel.toEntity()));
          } else {
            // Fallback to Firestore
            final fireStore = serviceLocator<FirebaseFirestore>();
            const role = 'User';
            final doc = await fireStore
                .collection('users')
                .doc(role)
                .collection(role)
                .doc(user.uid)
                .get();

            if (doc.exists) {
              final authUserModel =
                  UserModel.fromFirestore(doc.data()!, user.uid);
              // Save to SharedPreferences for future use
              await pref.setUSerId(authUserModel.id!);
              await pref.setName(authUserModel.name ?? '');
              await pref.setEmail(authUserModel.email);
              await pref.setPhotoUrl(authUserModel.photoUrl ?? '');
              await pref.setSignIn(authUserModel.googleSignIn ?? false);

              emit(Authenticated(authUserModel.toEntity()));
            } else {
              emit(const AuthError(
                  'User data not found. Please sign in again.'));
            }
          }
        } else {
          emit(AuthInitial());
        }
      } catch (e) {
        emit(AuthError('Error checking auth status: $e'));
      }
    });

    //------------------------------SignInEvent---------------------------------
    on<SignInEvent>((event, emit) async {
      emit(AuthInitial());
      final signIn = serviceLocator<SignInWithEmailPassword>();
      final pref = serviceLocator<PreferencesRepository>();
      final String category = await pref.getCategoryName();

      try {
        final result = await signIn.call(event.email, event.password);
        await result.fold(
          (error) => throw Exception(error),
          (user) async {
            emit(AuthLoading());
            if (category.isNotEmpty) {
              emit(Authenticated(user));
            } else {
              emit(AuthCategoryState());
            }
          },
        );
      } on Exception catch (e) {
        emit(AuthError(e.toString())); // Display the role validation error
      }
    });

    //------------------------------SignUpEvent---------------------------------
    on<SignUpEvent>((event, emit) async {
      emit(AuthInitial());
      final signUp = serviceLocator<SignUpWithEmailPassword>();

      try {
        final userData = AuthUser(
            email: event.email,
            name: event.name,
            password: event.password); // Create a User object

        final result = await signUp.call(
          name: event.name,
          email: event.email,
          password: event.password,
        );

        await result.fold(
          (error) => throw Exception(error),
          (user) async => emit(Authenticated(userData)),
        );
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state if sign-up fails
      }
    });

    //----------------------GoogleSignInEvent-----------------------------------
    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthInitial());
      final googleSignIn = serviceLocator<SignInWithGoogle>();
      final pref = serviceLocator<PreferencesRepository>();
      final String category = await pref.getCategoryName();
      try {
        final result = await googleSignIn.call(); // Call the sign-in method

        await result.fold(
          (error) => throw Exception(error),
          (user) async {
            emit(AuthLoading());

            if (category.isNotEmpty) {
              emit(Authenticated(user));
            } else {
              emit(AuthCategoryState());
            }
          },
        );
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
        emit(SignOutSuccessState()); // Emit Unauthenticated state
      } catch (e) {
        emit(AuthError(e.toString())); // Emit error state if sign-out fails
      }
    });
  }
}
