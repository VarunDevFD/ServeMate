import 'package:flutter/material.dart';

class CameraVideographyForm extends StatelessWidget {
  const CameraVideographyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFormHeader('Equipment Type'),
        _buildTextField('Enter equipment type (e.g., Camera, Lens, Gimbal)'),
        _buildFormHeader('Brand/Model'),
        _buildTextField('Enter brand and model'),
        _buildFormHeader('Rental Price (Per Day)'),
        _buildTextField('Enter rental price per day'),
        _buildFormHeader('Security Deposit'),
        _buildTextField('Enter security deposit amount'),
        _buildFormHeader('Condition'),
        _buildTextField('Enter condition (New, Like New, Good)'),
        _buildFormHeader('Available From - Till'),
        _buildTextField('Enter availability dates'),
        _buildFormHeader('Accessories Included'),
        _buildTextField('List any included accessories (e.g., Tripod, Memory Card)'),
        _buildFormHeader('Images'),
        // Placeholder for image upload functionality
        _buildFormHeader('Pickup/Delivery Option'),
        _buildTextField('Enter pickup or delivery option'),
        _buildFormHeader('Insurance Included (Yes/No)'),
        _buildTextField('Is insurance included?'),
        _buildFormHeader('Notes or Additional Information'),
        _buildTextField('Enter any additional notes'),
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
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
