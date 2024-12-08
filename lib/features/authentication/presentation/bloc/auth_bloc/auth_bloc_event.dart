import 'package:flutter/material.dart';

abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  final String role;
  final BuildContext context;

  SignInEvent(
      {required this.email,
      required this.password,
      required this.role,
      required this.context});

  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  // final String role;
  final BuildContext context;

  SignUpEvent(
      {required this.email,
      required this.password,
      // required this.role,
      required this.context});
}

class GoogleSignInEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
