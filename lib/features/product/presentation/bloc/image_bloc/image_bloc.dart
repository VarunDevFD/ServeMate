import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

// Events for ImageBloc

abstract class ImageEvent {}

class AddImageEvent extends ImageEvent {
  final String imagePath;

  AddImageEvent(this.imagePath);
}

class RemoveImageEvent extends ImageEvent {
  final int index;

  RemoveImageEvent(this.index);
}

class PickImageEvent extends ImageEvent {
  final ImageSource source;

  PickImageEvent({required this.source});
}

class ImagePickedEvent extends ImageEvent {
  final List<String> imagePaths; // Expecting a List<String> for image paths
  ImagePickedEvent(this.imagePaths);
}

// States for ImageBloc
abstract class ImageState {}

class ImageInitialState extends ImageState {}

class ImageLoadedState extends ImageState {
  final List<String> images;

  ImageLoadedState(this.images);
}

class ImagePickedState extends ImageState {
  final File image;
  ImagePickedState(this.image);
}

class ImagePickerErrorState extends ImageState {
  final String error;
  ImagePickerErrorState(this.error);
}

// Bloc for managing image state
class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImagePicker picker = ImagePicker();
  ImageBloc() : super(ImageInitialState()) {
    on<AddImageEvent>((event, emit) {
      final currentState = state;
      if (currentState is ImageLoadedState) {
        final updatedImages = List<String>.from(currentState.images)
          ..add(event.imagePath);
        emit(ImageLoadedState(updatedImages));
      } else {
        emit(ImageLoadedState([event.imagePath]));
      }
    });

    on<RemoveImageEvent>((event, emit) {
      final currentState = state;
      if (currentState is ImageLoadedState) {
        final updatedImages = List<String>.from(currentState.images);
        updatedImages
            .removeAt(event.index); // Remove the image at the specified index
        emit(ImageLoadedState(updatedImages));
      }
    });

    on<PickImageEvent>((event, emit) async {
      try {
        final pickedFile = await picker.pickImage(source: event.source);
        if (pickedFile != null) {
          emit(ImagePickedState(File(pickedFile.path)));
        } else {
          emit(ImagePickerErrorState('No image selected'));
        }
      } catch (e) {
        emit(ImagePickerErrorState('Failed to pick image: $e'));
      }
    });
  }
}
