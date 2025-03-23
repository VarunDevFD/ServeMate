class FormSubState {
  final String gender;

  FormSubState({
    this.gender = 'Male',
  });

  FormSubState copyWith({
    String? gender,
  }) {
    return FormSubState(
      gender: gender ?? this.gender,
    );
  }
}
