import 'package:serve_mate/features/auth/domain/repositories/auth_repo.dart';
import 'package:serve_mate/features/auth/domain/entities/user_entities.dart';

class SignInWithEmailPassword {
  final AuthRepository repository;

  SignInWithEmailPassword(this.repository);

  Future<UserEntity> call(String email, String password) async {
    return await repository.signInWithEmailPassword(email, password);
  }
}

class RegisterWithEmailPassword {
  final AuthRepository repository;

  RegisterWithEmailPassword(this.repository);

  Future<UserEntity> call(String email, String password) async {
    return await repository.registerWithEmailPassword(email, password);
  }
}
