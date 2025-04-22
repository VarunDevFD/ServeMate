import 'package:serve_mate/features/authentication/domain/entities/user_entity.dart';

abstract class AuthBlocState {
  const AuthBlocState();
}

class AuthInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class Authenticated extends AuthBlocState {
  final AuthUser user;

  const Authenticated(this.user);
}

class AuthCategoryState extends AuthBlocState {}

class SignOutSuccessState extends AuthBlocState {}

class AuthError extends AuthBlocState {
  final String message;

  const AuthError(this.message);
}

class Unauthenticated extends AuthBlocState {}
