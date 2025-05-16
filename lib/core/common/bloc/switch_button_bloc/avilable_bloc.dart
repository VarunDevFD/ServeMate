import 'package:flutter_bloc/flutter_bloc.dart';

class AccessButtonState {
  final bool isAdd; // true for "Add previous image", false for "Added"

  AccessButtonState({required this.isAdd});

  AccessButtonState copyWith({bool? isAdd}) {
    return AccessButtonState(
      isAdd: isAdd ?? this.isAdd,
    );
  }
}

class AccessButtonCubit extends Cubit<AccessButtonState> {
  AccessButtonCubit() : super(AccessButtonState(isAdd: true));

  void toggleButton() {
    emit(state.copyWith(isAdd: !state.isAdd));
  }
}
