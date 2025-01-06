import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

class ImagePickerFormField extends FormField<List<TextEditingController>> {
  ImagePickerFormField({
    Key? key,
    FormFieldSetter<List<TextEditingController>>? onSaved,
    FormFieldValidator<List<TextEditingController>>? validator,
    List<TextEditingController>? initialValue,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue ?? [],
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<List<TextEditingController>> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...state.value!.map((controller) {
                      final imagePath = controller.text;
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imagePath.isEmpty
                                    ? const AssetImage(
                                        'assets/placeholder_image.png',
                                      ) as ImageProvider
                                    : FileImage(File(imagePath)),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -10,
                            right: -10,
                            child: GestureDetector(
                              onTap: () {
                                state.value!.remove(controller);
                                state.didChange(state.value);
                              },
                              child: CircleAvatar(
                                radius: 12.r,
                                backgroundColor: AppColors.red,
                                child: Icon(
                                  Icons.close,
                                  size: 16.sp,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          final controller = TextEditingController(
                            text: pickedFile.path,
                          );

                          state.value!.add(controller);

                          state.didChange(state.value);
                        }
                      },
                      child: Container(
                        width: 100.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.grey,
                            width: 1.w,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add_a_photo,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (state.hasError)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      state.errorText ?? '',
                      style: TextStyle(
                        color: AppColors.red,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
}
