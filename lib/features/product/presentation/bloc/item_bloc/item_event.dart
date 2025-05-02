abstract class CommonEvent {}

class GenderChanged extends CommonEvent {
  final String type;
  GenderChanged(this.type);
}
