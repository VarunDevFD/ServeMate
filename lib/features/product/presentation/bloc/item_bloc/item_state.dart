abstract class CommonState {}

class InitialState extends CommonState {}

class LoadingState extends CommonState {}

class SuccessState extends CommonState {
  final String type;
  SuccessState(this.type);
}

class ErrorState extends CommonState {
  final String type;
  ErrorState(this.type);
}
