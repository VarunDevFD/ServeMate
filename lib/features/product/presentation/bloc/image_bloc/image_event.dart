part of 'image_bloc.dart';

sealed class ImageEvent {}

class PickImagesFromGallery extends ImageEvent {
  final double? maxWidth;
  final double? maxHeight;
  final int? quality;

  PickImagesFromGallery({this.maxWidth, this.maxHeight, this.quality});
}

class TakePhotoFromCamera extends ImageEvent {
  final double? maxWidth;
  final double? maxHeight;
  final int? quality;

  TakePhotoFromCamera({this.maxWidth, this.maxHeight, this.quality});
}

class UploadImagesToCloudinary extends ImageEvent {
   UploadImagesToCloudinary();
}

class RemoveImage extends ImageEvent {
  final int index;
  RemoveImage(this.index);
}

class ClearAllImages extends ImageEvent {}