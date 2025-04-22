import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_cubit/image_cubit_cubit.dart';

import '../bloc/form_submission_bloc/form_submission_event.dart';

class ImagePickerPage extends StatelessWidget {
  final String categoryName;
  final FormSubmissionBloc bloc;
  final String? Function(List<File>)? validator;

  ImagePickerPage({
    super.key,
    required this.categoryName,
    required this.bloc,
    this.validator,
  });

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  context.pop();
                  context
                      .read<ImagePickerCubit>()
                      .addImages(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
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
    return BlocListener<ImagePickerCubit, List<File>>(
      listener: (context, images) {
        final pics = images.map((e) => e.path).toList();
        // Update the FormSubmissionBloc only when images change
        bloc.add(FormUpdateEvent(categoryName, 'images', pics));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => _showImageSourceDialog(context),
            child: Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: const Color(0xFFFFECF1),
                border: Border.all(color: AppColors.imageBr),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 35.r,
                      color: AppColors.orange1,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Upload Images',
                      style: TextStyle(
                        color: AppColors.orange1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<ImagePickerCubit, List<File>>(
            builder: (context, images) {
              final validationError = validator?.call(images);
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
                  if (validationError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        validationError,
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
