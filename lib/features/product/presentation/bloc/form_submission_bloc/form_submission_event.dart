abstract class FormSubEvent {}

class FormUpdateEvent extends FormSubEvent {
  final String entityType;
  final String field;
  final dynamic value;

  FormUpdateEvent(this.entityType, this.field, this.value);
}

class FormSubmitEvent extends FormSubEvent {
  final String entityType;

  FormSubmitEvent(this.entityType);
}

class FormResetEvent extends FormSubEvent {}
