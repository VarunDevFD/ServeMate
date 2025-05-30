import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serve_mate/core/utils/image_handler.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImagePickerBloc extends Bloc<ImageEvent, ImageState> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerBloc() : super(const ImageInitial()) {
    on<PickImagesFromGallery>(_onPickImagesFromGallery);
    on<TakePhotoFromCamera>(_onTakePhotoFromCamera);
    on<RemoveImage>(_onRemoveImage);
    on<ClearAllImages>(_onClearAllImages);
    on<UploadImagesToCloudinary>(_onUploadImagesToCloudinary);
    on<ReadyToSaveEvent>(_onReadyToSave);
  }

  Future<void> _onReadyToSave(
    ReadyToSaveEvent event,
    Emitter<ImageState> emit,
  ) async {
    emit(const ReadyToSave());
  }

  Future<void> _onUploadImagesToCloudinary(
    UploadImagesToCloudinary event,
    Emitter<ImageState> emit,
  ) async {
    final currentImages = _getCurrentImages(state);
    if (currentImages.isEmpty) {
      emit(ImageError('No images to upload', previousImages: currentImages));
      return;
    }

    try {
      emit(UploadingImages());
      List<String> imageUrls = currentImages.map((file) => file.path).toList();

      final imagePath = await ImageHandler().processAndUploadImages(imageUrls);

      emit(ImagesUploaded(imagePath));
    } catch (e) {
      emit(ImageError(
        'Failed to upload images: ${e.toString()}',
        previousImages: currentImages,
      ));
    }
  }

  Future<void> _onPickImagesFromGallery(
    PickImagesFromGallery event,
    Emitter<ImageState> emit,
  ) async {
    try {
      emit(ImageLoading(previousImages: _getCurrentImages(state)));

      final pickedFiles = await _picker.pickMultiImage(
        maxWidth: event.maxWidth,
        maxHeight: event.maxHeight,
        imageQuality: event.quality,
      );

      if (pickedFiles.isNotEmpty) {
        final newImages = pickedFiles.map((file) => File(file.path)).toList();
        final updatedImages = [..._getCurrentImages(state), ...newImages];
        emit(ImageLoaded(updatedImages));
      } else {
        emit(ImageLoaded(_getCurrentImages(state)));
      }
    } catch (e) {
      emit(ImageError(e.toString(), previousImages: _getCurrentImages(state)));
    }
  }

  Future<void> _onTakePhotoFromCamera(
    TakePhotoFromCamera event,
    Emitter<ImageState> emit,
  ) async {
    try {
      emit(ImageLoading(previousImages: _getCurrentImages(state)));

      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: event.maxWidth,
        maxHeight: event.maxHeight,
        imageQuality: event.quality,
      );

      if (pickedFile != null) {
        final updatedImages = [
          ..._getCurrentImages(state),
          File(pickedFile.path)
        ];
        emit(ImageLoaded(updatedImages));
      } else {
        emit(ImageLoaded(_getCurrentImages(state)));
      }
    } catch (e) {
      emit(ImageError(e.toString(), previousImages: _getCurrentImages(state)));
    }
  }

  void _onRemoveImage(RemoveImage event, Emitter<ImageState> emit) {
    final currentImages = _getCurrentImages(state);
    if (event.index >= 0 && event.index < currentImages.length) {
      final updatedImages = List<File>.from(currentImages)
        ..removeAt(event.index);
      emit(updatedImages.isEmpty
          ? const ImageInitial()
          : ImageLoaded(updatedImages));
    } else {
      emit(ImageError('Invalid image index', previousImages: currentImages));
    }
  }

  void _onClearAllImages(ClearAllImages event, Emitter<ImageState> emit) {
    emit(const ImageInitial());
  }

  List<File> _getCurrentImages(ImageState state) => switch (state) {
        ImageInitial(images: final images) => images,
        ImageLoaded(images: final images) => images,
        UploadingImages() => [],
        ImageLoading(previousImages: final previousImages) =>
          previousImages ?? [],
        ImageError(previousImages: final previousImages) =>
          previousImages ?? [],
        ImagesUploaded() => const [], // Return empty list after upload
        ReadyToSave() => const [],
      };
}
