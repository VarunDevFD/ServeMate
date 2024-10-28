class TogglePasswordState {
  final bool passwordVisible;
  final bool confirmPasswordVisible;

  const TogglePasswordState({
    required this.passwordVisible,
    required this.confirmPasswordVisible,
  });

  TogglePasswordState copyWith({
    bool? passwordVisible,
    bool? confirmPasswordVisible,
  }) {
    return TogglePasswordState(
      passwordVisible: passwordVisible ?? this.passwordVisible,
      confirmPasswordVisible: confirmPasswordVisible ?? this.confirmPasswordVisible,
    );
  }
}
