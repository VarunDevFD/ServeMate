import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/theme/input_decoration.dart';

class VenueForm extends StatelessWidget {
  const VenueForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFormHeader('Venue Type'),
        _buildTextField('Enter venue type'),
        _buildFormHeader('Capacity'),
        _buildTextField('Enter capacity'),
        _buildFormHeader('Rental Price (Per Day)'),
        _buildTextField('Enter rental price'),
        _buildFormHeader('Available Dates'),
        _buildTextField('Enter available dates'),
        _buildFormHeader('Location/Address'),
        _buildTextField('Enter venue address'),
        _buildFormHeader('Facilities Provided'),
        _buildTextField('Enter facilities (AC, Projector, etc.)'),
        _buildFormHeader('Catering Included'),
        _buildTextField('Yes/No'),
        _buildFormHeader('Images of Venue'),
        // Additional image upload field can be added here
        _buildFormHeader('Special Instructions'),
        _buildTextField('Enter any special instructions'),
        _buildFormHeader('Advance Payment Required'),
        _buildTextField('Yes/No'),
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
