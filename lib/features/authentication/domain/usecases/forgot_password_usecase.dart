import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';

class SendPasswordResetEmailUseCase {
  final AuthRepository repository;

  SendPasswordResetEmailUseCase(this.repository);

  Future<void> call(String email) async {
    if (email.isEmpty) {
      throw Exception('Email is empty');
    }
    await repository.sendPasswordResetEmail(email);
  }
}
