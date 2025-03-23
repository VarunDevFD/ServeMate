import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCubit extends Cubit<List<File>> {
  ImagePickerCubit() : super([]);
  
  final ImagePicker _picker = ImagePicker();

  void addImages(ImageSource source) async {
    try {
      final List<XFile> pickedFiles = source == ImageSource.gallery
          ? await _picker.pickMultiImage()
          : [await _picker.pickImage(source: source)]
              .whereType<XFile>()
              .toList();
      
      final List<File> newImages = pickedFiles.map((xFile) => File(xFile.path)).toList();
      emit([...state, ...newImages]);
    } catch (e) {
      // Handle error (you might want to add error state)
      log('Error picking image: $e');
    }
  }

  void removeImage(int index) {
    final currentImages = List<File>.from(state);
    currentImages.removeAt(index);
    emit(currentImages);
  }

  void clearImages() {
    emit([]);
  }
}