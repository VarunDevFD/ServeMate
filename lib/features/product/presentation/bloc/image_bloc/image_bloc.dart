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

//BLoC State
class ImageState {
  final List<File> images;

  ImageState({required this.images});

  ImageState copyWith({List<File>? images}) {
    return ImageState(images: images ?? this.images);
  }
}

// ImageBloc using on<Event>
class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageState(images: [])) {
    // Handle AddImage event
    on<AddImage>((event, emit) {
      emit(state.copyWith(images: List.from(state.images)..add(event.image)));
    });

    // Handle RemoveImage event
    on<RemoveImage>((event, emit) {
      final updatedImages = List<File>.from(state.images)
        ..removeAt(event.index);
      emit(state.copyWith(images: updatedImages));
    });
  }
}
