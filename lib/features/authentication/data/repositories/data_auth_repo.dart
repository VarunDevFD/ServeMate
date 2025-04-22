import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/error/failure.dart';
import 'package:serve_mate/core/utils/app_exception.dart';
import 'package:serve_mate/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:serve_mate/features/authentication/data/models/user_model.dart';
import 'package:serve_mate/features/authentication/domain/entities/user_entity.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final remoteDataSource = serviceLocator<AuthDataSource>();

  //-------Sign-Up--------------------------------------------------------------
  @override
  Future<Either<String, AuthUser>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.signUpWithEmailPassword(
        UserModel(
          id: '',
          email: email,
          name: name,
          password: password,
        ),
      );
      return Right(userModel!.toEntity());
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      return Left('Sign-up error: $e');
    }
  }

  //-------Sign-In--------------------------------------------------------------

  @override
  Future<Either<String, AuthUser>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userModel =
          await remoteDataSource.signInWithEmailPassword(email, password);
      return Right(userModel.toEntity());
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      return Left('Sign-in error: $e');
    }
  }

  //-------Sign-In-Google-------------------------------------------------------

  @override
  Future<Either<String, AuthUser>> signInWithGoogle() async {
    try {
      final authUserModel = await remoteDataSource.signInWithGoogle();
      return Right(authUserModel.toEntity());
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      return Left('Sign-in error: $e');
    }
  }

  //-------Sign-Out--------------------------------------------------------

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

  Future<void> clearAuthUser() {
    throw UnimplementedError();
  }
}
