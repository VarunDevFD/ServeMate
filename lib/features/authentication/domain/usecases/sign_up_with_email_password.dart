import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';

class SignUpWithEmailPassword {
  final repository = serviceLocator<AuthRepository>();

  Future<void> call(
      String email, String password, BuildContext context) async {
    log("Domain: signUp uecase");

    return await repository.signUpWithEmailPassword(
        email, password, context);
  }
}
