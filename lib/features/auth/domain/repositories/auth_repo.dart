

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serve_mate/core/error/failure.dart';

abstract class AuthRepository {
  //--------------------Sign-In-------------------------------------------------
  Future<void> signInWithEmailPassword(String email, String password);

  //--------------------Sign-Up-------------------------------------------------
  Future<void> signUpWithEmailPassword(String email, String password);

  //--------------------Forget-Password-----------------------------------------
  Future<void> sendPasswordResetEmail(String email);

  //--------------------Get-Current-User----------------------------------------
  User? getCurrentUser();

  //--------------------Sign-In-Google------------------------------------------

  Future<User?> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  //--------------------Sign-Out------------------------------------------------
  Future<Either<Failure, void>> signOut();

  //--------------------Clear-SharedPreferences---------------------------------
  Future<void> clearAuthUser();
}
