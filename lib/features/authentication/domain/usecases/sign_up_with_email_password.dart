import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';

class SignUpWithEmailPassword {
  final repository = serviceLocator<AuthRepository>();

  Future<void> call(String name,String email, String password) async {
    return await repository.signUpWithEmailPassword(name, email, password);
  }
}
