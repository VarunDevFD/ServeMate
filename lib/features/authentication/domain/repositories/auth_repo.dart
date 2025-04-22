import 'package:dartz/dartz.dart'; 
import 'package:serve_mate/core/error/failure.dart';
import 'package:serve_mate/features/authentication/domain/entities/user_entity.dart';

abstract class AuthRepository {
  //---------------------------Sign-Up------------------------------------------
  Future<Either<String, AuthUser>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  //---------------------------Sign-In------------------------------------------
  Future<Either<String, AuthUser>> signInWithEmailPassword({
    required String email,
    required String password,
  });

  //---------------------------Sign-In-Google-----------------------------------
  Future<Either<String, AuthUser>> signInWithGoogle();

  //---------------------------Sign-Out-----------------------------------------
  Future<Either<Failure, void>> signOut();

  //---------------------------Forget-Password----------------------------------
  Future<void> sendPasswordResetEmail(String email);
}
