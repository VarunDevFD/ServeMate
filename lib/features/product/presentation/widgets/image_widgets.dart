import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';

class ImagePickerFormField extends StatelessWidget {
  final void Function(List<String>?) onSaved;
  final String? Function(List<String>?) validator;

  const ImagePickerFormField({
    Key? key,
    required this.onSaved,
    required this.validator,
  }) : super(key: key);

  // Function to pick an image from camera or gallery
  Future<void> pickImage(
    BuildContext context,
    ImageSource source,
    ImageBloc imageBloc,
  ) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      // Add picked image to Bloc
      imageBloc.add(AddImageEvent(pickedFile.path));

      // Show success snack bar
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Image selected from ${source == ImageSource.camera ? 'Camera' : 'Gallery'}',
            ),
          ),
        );
      });
    } else {
      // Show failure snack bar
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageBloc(),
      child: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          final imageBloc = context.read<ImageBloc>();
          final List<String> images =
              state is ImageLoadedState ? state.images : [];

          return FormField<List<String>>(
            onSaved: (value) => onSaved(images),
            validator: (value) {
              // Check if the images list is empty
              if (images.isEmpty) {
                return 'Please select at least one image';
              }
              return null;
            },
            builder: (fieldState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Add Image Button
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.0),
                          ),
                        ),
                        builder: (context) => Wrap(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Camera'),
                              onTap: () {
                                pickImage(
                                    context, ImageSource.camera, imageBloc);
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Gallery'),
                              onTap: () {
                                pickImage(
                                    context, ImageSource.gallery, imageBloc);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Pick Images'),
                  ),

                  const SizedBox(height: 16),

                  // Display selected images
                  if (images.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: images.map((imagePath) {
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Image Preview
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(File(imagePath)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // Remove Button
                            Positioned(
                              top: -8,
                              right: -8,
                              child: IconButton(
                                icon: Icon(Icons.highlight_remove,
                                    color: AppColors.red),
                                onPressed: () {
                                  imageBloc.add(RemoveImageEvent(
                                      images.indexOf(imagePath)));
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    )
                  else
                    const Text(
                      'No images selected',
                      style: TextStyle(color: AppColors.grey),
                    ),

                  // Validation error
                  if (fieldState.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        fieldState.errorText ?? '',
                        style: const TextStyle(color: AppColors.error),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
