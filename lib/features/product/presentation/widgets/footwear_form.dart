import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/theme/input_decoration.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_textfield_validator.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/text_field_with_color_picker.dart';

class FootwearForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final nameController = TextEditingController();
  final Function(String?) onColorSelected;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: 'Vehicle Name',
            child: CustomTextField(
              hint: 'Enter Vehicle Name',
              numberLimit: 20,
              controller: nameController,
              keyboardType: TextInputType.text,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter the Vehicle Name'
                  : null,
            ),
          ),
          // Color
          _buildSection(
            title: "Color",
            child: TextFieldWithColorPicker(
              hint: 'Enter color',
              onColorSelected: onColorSelected,
            ),
          ),
          _buildFormHeader('Footwear Type'),
          _buildTextField('Enter footwear type'),
          _buildFormHeader('Size'),
          _buildTextField('Enter size (UK, US, EU)'),
          _buildFormHeader('Color'),
          _buildTextField('Enter color'),
          _buildFormHeader('Brand/Designer'),
          _buildTextField('Enter brand/designer'),
          _buildFormHeader('Rental Price'),
          _buildTextField('Enter rental price'),
          _buildFormHeader('Security Deposit'),
          _buildTextField('Enter security deposit'),
          _buildFormHeader('Condition'),
          _buildTextField('Enter condition (New, Like New, Good)'),
          _buildFormHeader('Available From - Till'),
          _buildTextField('Enter availability dates'),
          _buildFormHeader('Images'),
          // Additional image upload field can be added here
          _buildFormHeader('Pickup/Delivery Option'),
          _buildTextField('Enter pickup or delivery option'),
        ],
      ),
    );
  }

  Widget _buildFormHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        decoration: InputDecorations.defaultDecoration(),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSideHeadText(title: title),
        child,
        SizedBox(height: 10.h),
      ],
    );
  }
}
