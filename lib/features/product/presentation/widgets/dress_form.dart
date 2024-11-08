import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serve_mate/core/utils/color_utils.dart';
import 'package:serve_mate/core/utils/theme/app_colors.dart';
import 'package:serve_mate/core/utils/theme/input_decoration.dart';
import 'package:serve_mate/core/widgets/custom_text.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/widgets/color_picker_widget.dart';

class DressForm extends StatelessWidget {
  const DressForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildGenderSelection(),
        _buildFormHeader('Dress Type'),
        BlocBuilder<DressFormBloc, DressFormState>(
          builder: (context, state) {
            return _buildDressTypeField(context, state.selectedGender);
          },
        ),
        _buildFormHeader('Size'),
        BlocBuilder<DressFormBloc, DressFormState>(
          builder: (context, state) {
            return _buildSizeDropdown(context, state.selectedSize);
          },
        ),
        _buildFormHeader('Color'),
        _buildTextFieldWithColorPicker('Enter color'),
        _buildFormHeader('Material'),
        _buildTextField('Enter material'),
        _buildFormHeader('Brand/Designer'),
        _buildTextField('Enter brand/designer'),
        _buildFormHeader('Rental Price'),
        _buildTextField(
          'Enter rental price',
          keyboardType: TextInputType.number,
        ),
        _buildFormHeader('Security Deposit'),
        _buildTextField(
          'Enter security deposit',
          keyboardType: TextInputType.number,
        ),
        _buildFormHeader('Condition'),
        BlocBuilder<DressFormBloc, DressFormState>(
          builder: (context, state) {
            return _buildConditionDropdown(context, state.selectedCondition);
          },
        ),
        _buildFormHeader('Available From - Till'),
        _buildTextField('Enter availability wre      dates'),
        _buildFormHeader('Special Requests'),
        _buildTextField('Enter any special requests'),
        _buildFormHeader('Images'),
        // BlocBuilder for ImageState
        BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Grid
                _buildImageGrid(context, state.images),
                // Add Image Button
                _buildAddImageButton(context),
              ],
            );
          },
        ),
        _buildFormHeader('Pickup/Delivery Option'),
        _buildLocationTextField(context, 'Enter pickup or delivery option'),
        _buildFormHeader('Notes or Additional Information'),
        _buildTextField('Enter any additional notes'),
        const SizedBox(height: 60)
      ],
    );
  }

  Widget _buildGenderSelection() {
    return BlocBuilder<DressFormBloc, DressFormState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Men'),
                value: 'Men',
                groupValue: state.selectedGender,
                activeColor: AppColors.primary,
                onChanged: (value) {
                  context.read<DressFormBloc>().add(GenderSelected(value!));
                },
                secondary: Icon(Icons.man_2_rounded,
                    color: state.selectedGender == 'Men'
                        ? AppColors.primary
                        : AppColors.grey),
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Girls'),
                value: 'Girls',
                groupValue: state.selectedGender,
                activeColor: AppColors.primary,
                onChanged: (value) {
                  context.read<DressFormBloc>().add(GenderSelected(value!));
                },
                secondary: Icon(Icons.girl_rounded,
                    color: state.selectedGender == 'Girls'
                        ? AppColors.primary
                        : AppColors.grey),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDressTypeField(BuildContext context, String selectedGender) {
    // Define dress types based on the selected gender
    List<String> dressTypes = (selectedGender == 'Men')
        ? ['Shirt', 'Tuxedo', 'Suit']
        : ['Dress', 'Gown', 'Sari'];

    // Ensure the default value is part of the list
    return BlocBuilder<DressFormBloc, DressFormState>(
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          value: (state.selectedDressType.isNotEmpty &&
                  dressTypes.contains(state.selectedDressType))
              ? state.selectedDressType
              : dressTypes.first, // default to the first item
          onChanged: (value) {
            context.read<DressFormBloc>().add(DressTypeChanged(value!));
          },
          items: dressTypes
              .map((dressType) => DropdownMenuItem<String>(
                    value: dressType,
                    child: Text(dressType),
                  ))
              .toList(),
          decoration: InputDecorations.defaultDecoration(),
        );
      },
    );
  }

  Widget _buildSizeDropdown(BuildContext context, String selectedSize) {
    // Predefined sizes
    List<String> sizes = ['Small', 'Medium', 'Large'];

    // Ensure the default value is part of the list
    return DropdownButtonFormField<String>(
      value: (selectedSize.isNotEmpty && sizes.contains(selectedSize))
          ? selectedSize
          : sizes.first, // default to the first item
      onChanged: (value) {
        context.read<DressFormBloc>().add(SizeChanged(value!));
      },
      items: sizes
          .map((size) => DropdownMenuItem<String>(
                value: size,
                child: Text(size),
              ))
          .toList(),
      decoration: InputDecorations.defaultDecoration(),
    );
  }

  Widget _buildFormHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomText(
        text: title,
        styleType: TextStyleType.blackBody,
      ),
    );
  }

  Widget _buildTextField(String hint,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        cursorColor: AppColors.balck1,
        decoration: InputDecorations.defaultDecoration(),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildTextFieldWithColorPicker(String hint) {
    return BlocBuilder<DressFormBloc, DressFormState>(
      builder: (context, state) {
        final TextEditingController controller = TextEditingController(
          text: state.colorName, // Show the color name in the text field
        );
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            cursorColor: AppColors.balck1,
            controller: controller,
            onChanged: (text) {
              final color =
                  getColorByName(text); // Function to convert text to color
              if (color != null) {
                // If color is found from name, update both color and colorName
                context.read<DressFormBloc>().add(ColorChanged(color, text));
              }
            },
            decoration: InputDecorations.defaultDecoration(
              suffixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: ColorPickerWidget(), // Color picker as the suffix icon
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageGrid(BuildContext context, List<File> images) {
    if (images.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child:
              Text('No images selected', style: TextStyle(color: Colors.grey)),
        ),
      );
    }
    return Card(
      color: const Color.fromARGB(255, 252, 217, 163),
      margin: const EdgeInsets.all(3),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: images.isNotEmpty
            ? Wrap(
                spacing: 8, // Horizontal space between items
                runSpacing: 8, // Vertical space between rows
                children: List.generate(images.length, (index) {
                  return Stack(
                    children: [
                      // Display selected images in a container with a fixed size
                      Container(
                        width: 100, // Adjust width as per design
                        height: 100, // Adjust height as per design
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(images[index]),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        right: -10,
                        top: -10,
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

  Widget _buildAddImageButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton.icon(
        onPressed: () async {
          final picker = ImagePicker();
          final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);

          if (pickedFile != null) {
            BlocProvider.of<ImageBloc>(context)
                .add(AddImage(File(pickedFile.path)));
          }
        },
        icon: Icon(Icons.image, color: AppColors.orange),
        label: Text('Add Image', style: TextStyle(color: AppColors.orange)),
      ),
    );
  }

  _buildConditionDropdown(BuildContext context, String selectedCondition) {
    List<String> conditions = ['New', 'Like New', 'Good'];

    return DropdownButtonFormField<String>(
      decoration: InputDecorations.defaultDecoration(),
      value: (selectedCondition.isNotEmpty &&
              conditions.contains(selectedCondition))
          ? selectedCondition
          : null, // Fix: Use null instead of 'Condition' as the default value

      items: conditions
          .map((condition) => DropdownMenuItem<String>(
                value: condition,
                child: Text(condition),
              ))
          .toList(),
      onChanged: (value) {
        context.read<DressFormBloc>().add(DressConditionChanged(value!));
      },
    );
  }

  Widget _buildLocationTextField(BuildContext context, String hint) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: BlocBuilder<DressFormBloc, DressFormState>(
        builder: (context, state) {
          return TextField(
            cursorColor: AppColors.balck1,
            decoration: InputDecoration(
              hintText: state.currentLocation ?? hint,
              suffixIcon: IconButton(
                icon: const Icon(Icons.location_on),
                onPressed: () {
                  // Inside your widget or anywhere you want to dispatch the event
                  BlocProvider.of<DressFormBloc>(context)
                      .add(CurrentLocation());
                },
              ),
              errorText: state.locationError,
            ),
            keyboardType: TextInputType.text,
            readOnly: true,
          );
        },
      ),
    );
  }
}
