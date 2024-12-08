class AuthUser {
  final String id;
  final String email;
  final String role;

  AuthUser({
    required this.id,
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'email': email,
      'role': role,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      id: map['uid'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
    );
  }
}
