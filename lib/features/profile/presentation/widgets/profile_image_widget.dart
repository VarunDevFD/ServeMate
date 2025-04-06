import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_cubit/image_cubit_cubit.dart';

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
                    context.pop();
                    context
                        .read<ImagePickerCubit>()
                        .addImages(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera, color: AppColors.primary),
                  title: const Text('Camera'),
                  onTap: () {
                    context.pop();
                    context
                        .read<ImagePickerCubit>()
                        .addImages(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showImagePreview(BuildContext context, File image, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(5.r),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InteractiveViewer(
                child: Image.file(
                  image,
                  fit: BoxFit.contain,
                  height: 400.h,
                  width: 300.w,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<ImagePickerCubit>().removeImage(index);
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.delete,
                size: 20.r,
                color: Colors.red,
              ),
              padding: EdgeInsets.all(8.r),
              constraints: BoxConstraints(
                minHeight: 40.h,
                minWidth: 40.w,
              ),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                'Close',
                style: TextStyle(fontSize: 14.sp, color: AppColors.balck1),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        GestureDetector(
          onTap: () => _showEditImageOptions(context), // Open image options
          child: CircleAvatar(
            radius: 50.r,
            backgroundColor: Colors.grey.shade300,
            // Show the selected image if available, else default image
            backgroundImage: const AssetImage('assets/images/profile_img.jpg')
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
        BlocBuilder<ImagePickerCubit, List<File>>(
          builder: (context, images) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (images.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Wrap(
                      spacing: 8.r,
                      runSpacing: 8.r,
                      children: images
                          .asMap()
                          .entries
                          .map(
                            (entry) => InkWell(
                              onTap: () => _showImagePreview(
                                  context, entry.value, entry.key),
                              child: Chip(
                                label: Container(
                                  height: 25.h,
                                  width: 25.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    image: DecorationImage(
                                      image: FileImage(entry.value),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                backgroundColor: AppColors.white2,
                                deleteIconColor: AppColors.orange1,
                                onDeleted: () => context
                                    .read<ImagePickerCubit>()
                                    .removeImage(entry.key),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
              ],
            );
          },
        ),
        // Display error if there is any image picking error

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Text(
            'name',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.red),
          ),
        ),
      ],
    ));
  }
}
