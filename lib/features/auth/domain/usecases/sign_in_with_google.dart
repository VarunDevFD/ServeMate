import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_mate/features/auth/domain/repositories/auth_repo.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<User?> call() {
    return repository
        .signInWithGoogle(); // Call the sign-in method from the repository
  }
}
