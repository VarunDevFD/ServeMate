import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_mate/core/error/failure.dart';
import 'package:serve_mate/features/authentication/domain/entities/user_entity.dart';

abstract class AuthRepository {
  //---------------------------Sign-Up------------------------------------------
  Future<void> signUpWithEmailPassword(String email, String password);

  //---------------------------Sign-In------------------------------------------
  Future<void> signInWithEmailPassword(String email, String password);

  //---------------------------Forget-Password----------------------------------
  Future<void> sendPasswordResetEmail(String email);
  //--------------------Get-Current-User----------------------------------------
  User? getCurrentUser();

  //---------------------------Sign-In-Google-----------------------------------

  Future<User?> signInWithGoogle();

  //---------------------------Sign-Out-----------------------------------------
  Future<Either<Failure, void>> signOut();

  //---------------------------Clear-SharedPreferences--------------------------
  Future<void> clearAuthUser();
}
