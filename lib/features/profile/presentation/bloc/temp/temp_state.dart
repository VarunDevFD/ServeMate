part of 'temp_bloc.dart';

class MyFormState {
  final Map<String, String> fields;
  final bool isValid;

  MyFormState({required this.fields, required this.isValid});

  factory MyFormState.initial() {
    return MyFormState(
      fields: {
        'Name': '',
        'Age': '',
        'Brand': '',
        'Model': '',
        'Size': '',
        'Height': '',
      },
      isValid: false,
    );
  }

  MyFormState copyWith({Map<String, String>? fields, bool? isValid}) {
    return MyFormState(
      fields: fields ?? this.fields,
      isValid: isValid ?? this.isValid,
    );
  }
}


