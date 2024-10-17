import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_mate/features/auth/domain/repositories/auth_repo.dart';

class GetCurrentUser {
  final AuthRepository repository;
  GetCurrentUser({required this.repository});

  User? call() {
    return repository.getCurrentUser();
  }
}
