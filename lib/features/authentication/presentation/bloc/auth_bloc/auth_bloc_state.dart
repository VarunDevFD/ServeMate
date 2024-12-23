
abstract class AuthBlocState {
  const AuthBlocState();
}

class AuthInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class Authenticated extends AuthBlocState {
  final dynamic user;

  const Authenticated(this.user);
}

class AuthSuccess extends AuthBlocState {}

class SignOutSuccessState extends AuthBlocState {}

class AuthError extends AuthBlocState {
  final String message;

  const AuthError(this.message);
}

class Unauthenticated extends AuthBlocState {}
