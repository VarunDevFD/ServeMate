import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/theme/input_decoration.dart';

class DecorationForm extends StatelessWidget {
  const DecorationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFormHeader('Decoration Type'),
        _buildTextField('Enter decoration type'),
        _buildFormHeader('Theme/Style'),
        _buildTextField('Enter theme/style'),
        _buildFormHeader('Rental Price'),
        _buildTextField('Enter rental price'),
        _buildFormHeader('Available From - Till'),
        _buildTextField('Enter availability dates'),
        _buildFormHeader('Images of Decoration Setups'),
        // Additional image upload field can be added here
        _buildFormHeader('Setup and Dismantling Services Included'),
        _buildTextField('Yes/No'),
        _buildFormHeader('Special Requests'),
        _buildTextField('Enter any special requests'),
        _buildFormHeader('Location for Setup'),
        _buildTextField('Enter setup location'),
        _buildFormHeader('Dimensions (If relevant)'),
        _buildTextField('Enter dimensions'),
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
