 
import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/authentication/domain/entities/user_entity.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';

class SignInWithGoogle {
  final repository = serviceLocator<AuthRepository>();

   Future<Either<String, AuthUser>> call() {
    // Call the sign-in method from the repository
    return repository.signInWithGoogle();
  }
}
