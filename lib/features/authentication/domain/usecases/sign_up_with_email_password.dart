import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/authentication/domain/entities/user_entity.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';

class SignUpWithEmailPassword {
  final repository = serviceLocator<AuthRepository>();

  Future<Either<String, AuthUser>> call({
    required String name,
    required String email,
    required String password,
  }) async {
    return await repository.signUpWithEmailPassword(
      name: name,
      email: email,
      password: password,
    );
  }
}
