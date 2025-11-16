import 'package:flutter_bloc/flutter_bloc.dart';

class CommonCubit extends Cubit<List<String>> {
  bool flag1 = false;
  CommonCubit(List<String> initialImages) : super(initialImages);
  void removeImage(int index) {
    final updatedImages = List<String>.from(state);
    updatedImages.removeAt(index);
    flag1 = true;
    emit(updatedImages);
  }

  void resetFlag() {
    flag1 = false;
  }
}
