import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';

// Image Grid Widget
Widget buildImageGrid(BuildContext context, List<File> images) {
  if (images.isEmpty) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Center(
        child:
            Text('No images selected', style: TextStyle(color: AppColors.grey)),
      ),
    );
  }

  return Card(
    color: AppColors.orange2,
    margin: EdgeInsets.all(3.r),
    child: Padding(
      padding: EdgeInsets.all(5.0.r),
      child: images.isNotEmpty
          ? Wrap(
              spacing: 8, // Horizontal space between items
              runSpacing: 8, // Vertical space between rows
              children: List.generate(images.length, (index) {
                return Stack(
                  children: [
                    // Display selected images in a container with a fixed size
                    Container(
                      width: 100.w, // Adjust width as per design
                      height: 100.h, // Adjust height as per design
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                          image: FileImage(images[index]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      right: -10.w,
                      top: -10.h,
                      child: IconButton(
                        icon: Icon(
                          Icons.highlight_remove,
                          color: AppColors.red,
                        ),
                        onPressed: () {
                          BlocProvider.of<ImageBloc>(context)
                              .add(RemoveImage(index));
                        },
                      ),
                    ),
                  ],
                );
              }),
            )
          : Center(
              child: Icon(
                Icons.image,
                color: AppColors.orange1,
              ),
            ),
    ),
  );
}

// Add Image Button Widget

Widget buildAddImageButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: ElevatedButton.icon(
      onPressed: () => _showImageSourceSelection(context),
      icon: Icon(Icons.image, color: AppColors.orange),
      label: Text('Add Image', style: TextStyle(color: AppColors.orange)),
    ),
  );
}

// Function to show image source selection dialog
void _showImageSourceSelection(BuildContext context) {
  final picker = ImagePicker();

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose Image Source',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Camera Button
                ElevatedButton.icon(
                  onPressed: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      Navigator.pop(context); // Close bottom sheet
                      BlocProvider.of<ImageBloc>(context)
                          .add(AddImage(File(pickedFile.path)));
                    }
                  },
                  icon: Icon(Icons.camera_alt, color: AppColors.orange),
                  label:
                      Text('Camera', style: TextStyle(color: AppColors.orange)),
                ),
                // Gallery Button
                ElevatedButton.icon(
                  onPressed: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      Navigator.pop(context); // Close bottom sheet
                      BlocProvider.of<ImageBloc>(context)
                          .add(AddImage(File(pickedFile.path)));
                    }
                  },
                  icon: Icon(Icons.photo_library, color: AppColors.orange),
                  label: Text('Gallery',
                      style: TextStyle(color: AppColors.orange)),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class ImagePickerFormField extends FormField<List<String>> {
  ImagePickerFormField({
    Key? key,
    required BuildContext context,
    required Function(List<String>) onSaved,
    String? Function(List<String>?)? validator,
  }) : super(
          key: key,
          initialValue: const [],
          onSaved: (value) => onSaved(value ?? []),
          validator: validator,
          builder: (FormFieldState<List<String>> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ImageBloc, ImageState>(
                  builder: (context, imageState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display selected images
                        buildImageGrid(context, imageState.images),

                        // Error message if validation fails
                        if (state.errorText != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              state.errorText!,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  fontSize: 12),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8),
                // Button to add new images
                buildAddImageButton(context),
              ],
            );
          },
        );
}
