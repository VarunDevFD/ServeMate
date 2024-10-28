class AuthUser {
  final String id;
  final String email;
  final String? password;

  AuthUser({required this.id, required this.email, this.password});
}
