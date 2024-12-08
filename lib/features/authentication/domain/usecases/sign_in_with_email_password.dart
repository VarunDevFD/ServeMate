import 'package:flutter/material.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';

class SignInWithEmailPassword {
  final AuthRepository repository;

  SignInWithEmailPassword(this.repository);

  Future<void> call(String email, String password, String role, BuildContext context) async {
    return await repository.signInWithEmailPassword(email, password, role, context);
  }
}
