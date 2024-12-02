import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/theme/input_decoration.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';

class JewelryForm extends StatelessWidget {
  const JewelryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Name
        // Category
        // Price
        // Available Quantity
        // Material
        // Condition
        // Brand
        // Size/ Dimension
        // Color
        // Images
        // Location
        // Rental Duration
        // Price
        // Security
        // Availability Status
        // Add Note
        

        _buildFormHeader('Jewelry Type'),
        _buildTextField('Enter jewelry type'),
        _buildFormHeader('Material'),
        _buildTextField('Enter material type'),
        _buildFormHeader('Weight (In grams)'),
        _buildTextField('Enter weight if applicable'),
        _buildFormHeader('Rental Price'),
        _buildTextField('Enter rental price'),
        _buildFormHeader('Security Deposit'),
        _buildTextField('Enter security deposit'),
        _buildFormHeader('Available From - Till'),
        _buildTextField('Enter availability dates'),
        _buildFormHeader('Condition'),
        _buildTextField('Enter condition (New, Like New, Good)'),
        _buildFormHeader('Images'),
        // Additional image upload field can be added here
        _buildFormHeader('Terms for Usage'),
        _buildTextField('Enter usage conditions'),
        _buildFormHeader('Pickup/Delivery Option'),
        _buildTextField('Enter pickup or delivery option'),
        const SizedBox(
          height: 50,
        )
      ],
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
