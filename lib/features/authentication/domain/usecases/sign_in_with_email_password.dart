 
import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/authentication/domain/entities/user_entity.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';

class SignInEmailPasswordUseCase {
  final repository = serviceLocator<AuthRepository>();

  Future<Either<String, AuthUser>> call(
    String email,
    String password,
    String role,
  ) async {
    return await repository.signInWithEmailPassword(
      email: email,
      password: password,
    );
  }
}
