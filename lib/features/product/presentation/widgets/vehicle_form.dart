import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/theme/input_decoration.dart';

class VehicleForm extends StatelessWidget {
  const VehicleForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFormHeader('Vehicle Type'),
        _buildTextField('Enter vehicle type'),
        _buildFormHeader('Brand/Model'),
        _buildTextField('Enter brand/model'),
        // Continue adding fields...
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
