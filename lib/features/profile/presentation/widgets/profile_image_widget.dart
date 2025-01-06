import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';

class ImageProfile extends StatelessWidget {
  const ImageProfile({super.key});

  void _showEditImageOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: SizedBox(
            height: 100.h,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.photo, color: AppColors.primary),
                  title: const Text('Gallery'),
                  onTap: () {
                    BlocProvider.of<ImageBloc>(context)
                        .add(PickImageEvent(source: ImageSource.gallery));
                    context.pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera, color: AppColors.primary),
                  title: const Text('Camera'),
                  onTap: () {
                    BlocProvider.of<ImageBloc>(context)
                        .add(PickImageEvent(source: ImageSource.camera));
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      builder: (context, state) {
        String? imagePath;

        // Check if image has been picked
        if (state is ImagePickedState) {
          imagePath = state.image.path; // Get the image path from state
        }

        return Center(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () =>
                    _showEditImageOptions(context), // Open image options
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundColor: Colors.grey.shade300,
                  // Show the selected image if available, else default image
                  backgroundImage: imagePath != null
                      ? FileImage(
                          File(imagePath)) // Image picked from gallery/camera
                      : const AssetImage('assets/images/profile_img.jpg')
                          as ImageProvider, // Default image
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 15.r,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.edit,
                        size: 15.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              // Display error if there is any image picking error
              if (state is ImagePickerErrorState)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Text(
                    state.error, // Show error message
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.red),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
