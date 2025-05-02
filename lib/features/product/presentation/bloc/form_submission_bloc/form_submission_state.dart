abstract class AddProductState {
  const AddProductState();
}

class AddIntialState extends AddProductState {}

class AddLoadingState extends AddProductState {}

class AddSuccessState extends AddProductState {
  final String message;

  AddSuccessState(this.message);
}

class AddFormError extends AddProductState {
  final String message;

  AddFormError(this.message);
}
