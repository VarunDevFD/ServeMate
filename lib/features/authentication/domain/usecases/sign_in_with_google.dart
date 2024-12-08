import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';

class SignInWithGoogle {
  final repository = serviceLocator<AuthRepository>();

  Future<User?> call() {
    // Call the sign-in method from the repository
    return repository.signInWithGoogle();
  }
}
