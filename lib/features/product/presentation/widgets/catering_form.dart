import 'package:flutter/material.dart';

class CateringForm extends StatelessWidget {
  const CateringForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFormHeader('Cuisine Type'),
        _buildTextField('Enter cuisine type'),
        _buildFormHeader('Menu Options'),
        _buildTextField('Enter menu options'),
        _buildFormHeader('Per Plate Cost'),
        _buildTextField('Enter cost per plate'),
        _buildFormHeader('Number of Guests'),
        _buildTextField('Enter minimum/maximum guests'),
        _buildFormHeader('Available Dates'),
        _buildTextField('Enter available dates'),
        _buildFormHeader('Service Location'),
        _buildTextField('Enter service location'),
        _buildFormHeader('Includes Catering Equipment'),
        _buildTextField('Yes/No'),
        _buildFormHeader('Additional Services'),
        _buildTextField('Enter additional services offered'),
        _buildFormHeader('Images of Sample Setups'),
        // Additional image upload field can be added here
        _buildFormHeader('Special Requests'),
        _buildTextField('Enter any special requests'),
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
