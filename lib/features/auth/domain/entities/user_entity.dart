class AuthUser {
  final String id;
  final String email;
  final String? displayName;

  AuthUser({required this.id, required this.email, this.displayName});
}
