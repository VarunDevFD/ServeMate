import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

// Define BLoC Events
abstract class ImageEvent {}

class AddImage extends ImageEvent {
  final File image;
  AddImage(this.image);
}

class RemoveImage extends ImageEvent {
  final int index;
  RemoveImage(this.index);
}

// Define BLoC State
class ImageState {
  final List<File> images;

  ImageState(this.images);
}

// Define ImageBloc using on<Event>
class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageState([])) {
    // Handle AddImage event
    on<AddImage>((event, emit) {
      final updatedImages = List<File>.from(state.images)..add(event.image);
      emit(ImageState(updatedImages));
    });

    // Handle RemoveImage event
    on<RemoveImage>((event, emit) {
      final updatedImages = List<File>.from(state.images)..removeAt(event.index);
      emit(ImageState(updatedImages));
    });
  }
}
