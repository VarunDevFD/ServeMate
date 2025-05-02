import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';

class ImagePickerPage extends StatelessWidget {
  const ImagePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerBloc, ImageState>(
      listener: (context, state) {
        if (state is ImageError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final images = switch (state) {
          ImageInitial(images: final images) => images,
          UploadingImages() => [],
          ImageLoading(previousImages: final previousImages) =>
            previousImages ?? const [],
          ImageLoaded(images: final images) => images,
          ImagesUploaded() => [],
          ImageError(previousImages: final previousImages) =>
            previousImages ?? const [],
        };

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upload button
            InkWell(
              onTap: () => _showImageSourceDialog(context),
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFECF1),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 35.r,
                        color: Colors.orange,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        images.isEmpty ? 'Upload Images' : 'Add more images',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (images.isNotEmpty) ...[
              SizedBox(height: 16.h),
              SizedBox(
                height: 100.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Stack(
                        children: [
                          Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              image: DecorationImage(
                                image: FileImage(images[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => context
                                  .read<ImagePickerBloc>()
                                  .add(RemoveImage(index)),
                              child: Container(
                                padding: EdgeInsets.all(4.r),
                                decoration: const BoxDecoration(
                                  color: AppColors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 16.r,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      context.read<ImagePickerBloc>().add(ClearAllImages()),
                  child:
                      Text('Clear All', style: TextStyle(color: AppColors.red)),
                ),
              ),
             
            ],
          ],
        );
      },
    );
  }

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
                  Navigator.pop(context);
                  context.read<ImagePickerBloc>().add(PickImagesFromGallery());
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  context.read<ImagePickerBloc>().add(TakePhotoFromCamera());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
