import 'package:flutter_bloc/flutter_bloc.dart';

class CommonCubit extends Cubit<List<String>> {
  CommonCubit(List<String> initialImages) : super(initialImages);

  void removeImage(int index) {
    final updatedImages = List<String>.from(state);
    updatedImages.removeAt(index);
    emit(updatedImages);
  }

  void addImage(String imageUrl) {
    final updatedImages = List<String>.from(state)..add(imageUrl);
    emit(updatedImages);
  }
}
