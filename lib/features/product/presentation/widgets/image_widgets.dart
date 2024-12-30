import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
            // List<String> imagesPaths = [];
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
                            width: 100,
                            height: 100,
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
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.white,
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
                          // imagesPaths.add(pickedFile.path);
                          // log(imagesPaths.toString());
                          state.didChange(state.value);
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      state.errorText ?? '',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
}
