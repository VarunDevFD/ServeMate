import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/error/failure.dart';
import 'package:serve_mate/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final remoteDataSource = serviceLocator<AuthRemoteDataSource>();
  final firestore = serviceLocator<FirebaseFirestore>();

  //-------Sign-Up--------------------------------------------------------------
  @override
  Future<void> signUpWithEmailPassword(
      String name, String email, String password) {
    return remoteDataSource.signUpWithEmailPassword(
      name,
      email,
      password,
    );
  }

  //-------Sign-In--------------------------------------------------------------
  @override
  Future<bool> signInWithEmailPassword(
    String email,
    String password,
    String role,
  ) async {
    // Delegate the sign-in process to the remote data source
    return await remoteDataSource.signInWithEmailPassword(
        email, password, role);
  }

  //-------Sign-In-Google-------------------------------------------------------

  @override
  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // Obtain the auth details from the Google sign-in request
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a credential from the Google sign-in token
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase using the Google credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user; // Return the signed-in user
    }

    return null; // Return null if the sign-in failed or was canceled
  }

/*
  @override
  User? getCurrentUser() {
    return remoteDataSource.getCurrentUser();
  }
  */

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure()); // Replace with your custom failure
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    throw UnimplementedError();
  }

  @override
  Future<void> clearAuthUser() {
    throw UnimplementedError();
  }
}
