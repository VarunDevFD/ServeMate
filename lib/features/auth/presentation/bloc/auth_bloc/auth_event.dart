abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterEvent(this.email, this.password);
}
