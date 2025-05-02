import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';

class ImageProfile extends StatelessWidget {
  final String? imageUrl;

  const ImageProfile({
    super.key,
    this.imageUrl,
  });

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
                  onTap: () async {
                    context.pop();
                    final picker = ImagePicker();
                    final pickedFiles = await picker.pickMedia();
                    if (pickedFiles != null) {
                      // Convert XFile to File
                      context
                          .read<ImagePickerBloc>()
                          .add(PickImagesFromGallery());
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera, color: AppColors.primary),
                  title: const Text('Camera'),
                  onTap: () async {
                    context.pop();
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      // Convert XFile to File
                      context
                          .read<ImagePickerBloc>()
                          .add(TakePhotoFromCamera());
                    }
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
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () => _showEditImageOptions(context),
              child: BlocBuilder<ImagePickerBloc, ImageState>(
                builder: (context, state) {
                  return CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.grey.shade300,
                    // backgroundImage: imageUrl != null
                    //     ? FileImage(File(imageUrl!))
                    //     : (state.images.isNotEmpty
                    //             ? FileImage(state.images.first)
                    //             : const AssetImage(
                    //                 'assets/images/profile_img.jpg'))
                    //         as ImageProvider,
                    // images.isNotEmpty
                    //     ? FileImage(images.first)
                    //     : (imageUrl != null
                    //             ? FileImage(File(imageUrl!))
                    //             : const AssetImage(
                    //                 'assets/images/profile_img.jpg'))
                    //         as ImageProvider,
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
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
