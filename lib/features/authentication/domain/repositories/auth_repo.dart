import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_mate/core/error/failure.dart';

abstract class AuthRepository {
  //---------------------------Sign-Up------------------------------------------
  Future<void> signUpWithEmailPassword(
      String name, String email, String password);

  //---------------------------Sign-In------------------------------------------
  Future<bool> signInWithEmailPassword(
      String email, String password, String role);

  //---------------------------Forget-Password----------------------------------
  Future<void> sendPasswordResetEmail(String email);
  //--------------------Get-Current-User----------------------------------------

  //---------------------------Sign-In-Google-----------------------------------

  Future<User?> signInWithGoogle();

  //---------------------------Sign-Out-----------------------------------------
  Future<Either<Failure, void>> signOut();

  //---------------------------Clear-SharedPreferences--------------------------
  Future<void> clearAuthUser();
}
