import 'package:serve_mate/features/auth/domain/repositories/auth_repo.dart';

class SignUpWithEmailPassword {
  final AuthRepository repository;

  SignUpWithEmailPassword(this.repository);

  Future<void> call(String email, String password) async {
    return await repository.signUpWithEmailPassword(email, password);
  }
}
