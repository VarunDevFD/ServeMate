abstract class FormSubmissionEvent {}

class InitializeForm extends FormSubmissionEvent {}

class UpdateField extends FormSubmissionEvent {
  final String field;
  final dynamic value;

  UpdateField(this.field, this.value);
}

class DecorationUpdateField extends FormSubmissionEvent {
  final String field;
  final dynamic value;

  DecorationUpdateField(this.field, this.value);
}

class DressUpdateField extends FormSubmissionEvent {
  final String field;
  final dynamic value;

  DressUpdateField(this.field, this.value);
}

class FootWearUpdateField extends FormSubmissionEvent {
  final String field;
  final dynamic value;

  FootWearUpdateField(this.field, this.value);
}

class JewelryUpdateField extends FormSubmissionEvent {
  final String field;
  final dynamic value;

  JewelryUpdateField(this.field, this.value);
}

class SoundUpdateField extends FormSubmissionEvent {
  final String field;
  final dynamic value;

  SoundUpdateField(this.field, this.value);
}

class CameraEvent extends FormSubmissionEvent {}

class DecorationEvent extends FormSubmissionEvent {}

class DressEvent extends FormSubmissionEvent {}

class FootWearEvent extends FormSubmissionEvent {}

class JewelryEvent extends FormSubmissionEvent {}

class SoundEvent extends FormSubmissionEvent {}

class ResetForm extends FormSubmissionEvent {}
