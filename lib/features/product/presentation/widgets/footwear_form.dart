import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/theme/input_decoration.dart';

class FootwearForm extends StatelessWidget {
  const FootwearForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
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
}
