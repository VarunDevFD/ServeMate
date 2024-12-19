abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  final String role;

  SignInEvent({
    required this.email,
    required this.password,
    required this.role,
  });
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class GoogleSignInEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
