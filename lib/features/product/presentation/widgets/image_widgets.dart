// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:serve_mate/core/theme/app_colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ImagePickerPage extends StatelessWidget {
//   final ValueNotifier<List<File>> imageNotifier;

//   final ImagePicker _picker = ImagePicker();
//   ImagePickerPage({super.key, required this.imageNotifier});

//   // Method to show image source bottom sheet
//   void _showImageSourceDialog(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Gallery'),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   _pickImages(ImageSource.gallery);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text('Camera'),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   _pickImages(ImageSource.camera);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Method to pick images
//   void _pickImages(ImageSource source) async {
//     try {

//       // Allow multiple image selection for gallery
//       final List<XFile> pickedFiles = source == ImageSource.gallery
//           ? await _picker.pickMultiImage()
//           : [await _picker.pickImage(source: source)]
//               .whereType<XFile>()
//               .toList();

//       // Convert XFile to File and add to the list
//       final List<File> newImages =
//           pickedFiles.map((xFile) => File(xFile.path)).toList();

//       // Update the value notifier with new images
//       imageNotifier.value = [...imageNotifier.value, ...newImages];
//     } catch (e) {
//       log('Error picking image: $e');
//     }
//   }

//   // Method to remove an image
//   void _removeImage(int index) {
//     final List<File> currentImages = List.from(imageNotifier.value);
//     currentImages.removeAt(index);
//     imageNotifier.value = currentImages;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ValueListenableBuilder<List<File>>(
//           valueListenable: imageNotifier,
//           builder: (context, images, _) {
//             return images.isEmpty
//                 ? Container(
//                     height: 20.h,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'No images selected',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   )
//                 : Container(
//                     height: 100.h,
//                     margin:
//                         EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: images.length,
//                       itemBuilder: (context, index) {
//                         return Stack(
//                           children: [
//                             Container(
//                               width: 80.h,
//                               margin: EdgeInsets.all(8.r),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.r),
//                                 image: DecorationImage(
//                                   image: FileImage(images[index]),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               top: 0,
//                               right: 0,
//                               child: GestureDetector(
//                                 onTap: () => _removeImage(index),
//                                 child: Icon(Icons.close, color: AppColors.red),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   );
//           },
//         ),
//         SizedBox(height: 6.h),
//         GestureDetector(
//           onTap: () => _showImageSourceDialog(context),
//           child: Container(
//             width: double.infinity,
//             height: 40.h,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Center(child: Icon(Icons.add_a_photo)),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePickerPage extends StatelessWidget {
  final ValueNotifier<List<File>> imageNotifier;

  final ImagePicker _picker = ImagePicker();
  ImagePickerPage({super.key, required this.imageNotifier});

  // Method to show image source bottom sheet
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
                  _pickImages(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  context.pop();
                  _pickImages(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to pick images
  void _pickImages(ImageSource source) async {
    try {
      // Allow multiple image selection for gallery
      final List<XFile> pickedFiles = source == ImageSource.gallery
          ? await _picker.pickMultiImage()
          : [await _picker.pickImage(source: source)]
              .whereType<XFile>()
              .toList();

      // Convert XFile to File and add to the list
      final List<File> newImages =
          pickedFiles.map((xFile) => File(xFile.path)).toList();

      // Update the value notifier with new images
      imageNotifier.value = [...imageNotifier.value, ...newImages];
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  // Method to remove an image
  void _removeImage(int index) {
    final List<File> currentImages = List.from(imageNotifier.value);
    currentImages.removeAt(index);
    imageNotifier.value = currentImages;
  }

  void _showImagePreview(BuildContext context, File image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(5.r),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Full size image
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
            // Delete button changed to IconButton
            IconButton(
              onPressed: () {
                _removeImage(imageNotifier.value.indexOf(image));
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => _showImageSourceDialog(context),
          child: Container(
            height: 100.h,
            decoration: BoxDecoration(
              color: const Color(0xFFFFECF1),
              border: Border.all(color: const Color(0xFFEEEEEE)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 35.r,
                    color: const Color(0xFFFF9800),
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
        if (imageNotifier.value.isNotEmpty)
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Wrap(
              spacing: 8.r,
              runSpacing: 8.r,
              children: imageNotifier.value
                  .map(
                    (image) => InkWell(
                      onTap: () => _showImagePreview(context, image),
                      child: Chip(
                        label: Container(
                          height: 25.h,
                          width: 25.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            image: DecorationImage(
                              image: FileImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        backgroundColor: AppColors.white2,
                        deleteIconColor: AppColors.orange1,
                        onDeleted: () =>
                            _removeImage(imageNotifier.value.indexOf(image)),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          
      ],
    );
  }
}
