import 'package:serve_mate/features/auth/domain/entities/user_entities.dart';

abstract class AuthRepository {
  Future<UserEntity> signInWithEmailPassword(String email, String password);
  Future<UserEntity> registerWithEmailPassword(String email, String password);
}
