import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Events for ImageBloc
abstract class ImageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddImageEvent extends ImageEvent {
  final String imagePath;

  AddImageEvent(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class RemoveImageEvent extends ImageEvent {
  final int index;

  RemoveImageEvent(this.index);

  @override
  List<Object?> get props => [index];
}

// States for ImageBloc
abstract class ImageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImageInitialState extends ImageState {}

class ImageLoadedState extends ImageState {
  final List<String> images;

  ImageLoadedState(this.images);

  @override
  List<Object?> get props => [images];
}

// Bloc for managing image state
class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitialState()) {
    on<AddImageEvent>((event, emit) {
      final currentState = state;
      if (currentState is ImageLoadedState) {
        final updatedImages = List<String>.from(currentState.images)..add(event.imagePath);
        emit(ImageLoadedState(updatedImages));
      } else {
        emit(ImageLoadedState([event.imagePath]));
      }
    });

    on<RemoveImageEvent>((event, emit) {
      final currentState = state;
      if (currentState is ImageLoadedState) {
        final updatedImages = List<String>.from(currentState.images);
        updatedImages.removeAt(event.index);  // Remove the image at the specified index
        emit(ImageLoadedState(updatedImages));
      }
    });
  }
}
