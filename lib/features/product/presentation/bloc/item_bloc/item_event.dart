abstract class FormSubEvent {
  const FormSubEvent();
}

class GenderChanged extends FormSubEvent {
  final String gender;
  const GenderChanged(this.gender);
}
