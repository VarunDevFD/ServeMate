import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';

class SignInEmailPasswordUseCase {
  final repository = serviceLocator<AuthRepository>();

  Future<bool> call(
    String email,
    String password,
    String role,
  ) async {
    return await repository.signInWithEmailPassword(email, password, role);
  }
}
