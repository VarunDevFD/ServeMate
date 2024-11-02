// state.dart
class DressFormState {
  final String selectedGender;
  final String selectedDressType;
  final String selectedSize;

  DressFormState({
    this.selectedGender = '',
    this.selectedDressType = '',
    this.selectedSize = '',
  });

  DressFormState copyWith({
    String? selectedGender,
    String? selectedDressType,
    String? selectedSize,
  }) {
    return DressFormState(
      selectedGender: selectedGender ?? this.selectedGender,
      selectedDressType: selectedDressType ?? this.selectedDressType,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }
}
