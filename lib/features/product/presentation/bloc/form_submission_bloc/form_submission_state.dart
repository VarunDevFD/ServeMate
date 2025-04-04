abstract class FormSubState {}

class FormInitial extends FormSubState {
  final Map<String, dynamic> entities;

  FormInitial(this.entities);

  FormInitial copyWith({Map<String, dynamic>? entities}) {
    return FormInitial(entities ?? this.entities);
  }
}

class FormLoading extends FormSubState {
  final String categoryType;

  FormLoading(this.categoryType);
}

class FormSuccess extends FormSubState {
  final String entityType;
  final dynamic data;

  FormSuccess(this.entityType, this.data);
}

class FormError extends FormSubState {
  final String message;

  FormError(this.message);
}