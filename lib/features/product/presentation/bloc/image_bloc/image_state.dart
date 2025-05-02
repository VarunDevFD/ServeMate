part of 'image_bloc.dart';

sealed class ImageState {
  const ImageState();
}

class ImageInitial extends ImageState {
  final List<File> images;
  const ImageInitial({this.images = const []});
}

class UploadingImages extends ImageState {}

class ImageLoading extends ImageState {
  final List<File>? previousImages;
  const ImageLoading({this.previousImages});
}

class ImageLoaded extends ImageState {
  final List<File> images;
  const ImageLoaded(this.images);

}

class ImagesUploaded extends ImageState {
  final List<String> imageUrls;
  const ImagesUploaded(this.imageUrls);
}

class ImageError extends ImageState {
  final String message;
  final List<File>? previousImages;
  const ImageError(this.message, {this.previousImages});
}