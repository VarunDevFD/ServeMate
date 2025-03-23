// import 'package:flutter/material.dart';
// import 'package:serve_mate/core/theme/input_decoration.dart';

// class SoundDJForm extends StatelessWidget {
//   const SoundDJForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         _buildFormHeader('Equipment Type'),
//         _buildTextField('Enter equipment type (e.g., DJ Set, Speakers, Mixer)'),
//         _buildFormHeader('Brand/Model'),
//         _buildTextField('Enter brand and model'),
//         _buildFormHeader('Rental Price (Per Day)'),
//         _buildTextField('Enter rental price per day'),
//         _buildFormHeader('Security Deposit'),
//         _buildTextField('Enter security deposit amount'),
//         _buildFormHeader('Condition'),
//         _buildTextField('Enter condition (New, Like New, Good)'),
//         _buildFormHeader('Available From - Till'),
//         _buildTextField('Enter availability dates'),
//         _buildFormHeader('Setup and Dismantling Services Included (Yes/No)'),
//         _buildTextField(
//             'Enter whether setup and dismantling services are included'),
//         _buildFormHeader('Images'),
//         // Placeholder for image upload functionality
//         _buildFormHeader('Pickup/Delivery Option'),
//         _buildTextField('Enter pickup or delivery option'),
//         _buildFormHeader('Notes or Additional Information'),
//         _buildTextField('Enter any additional notes'),
//       ],
//     );
//   }

//   Widget _buildFormHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 16.0),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _buildTextField(String hint) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: TextField(
//         decoration: InputDecorations.defaultDecoration(),
//       ),
//     );
//   }
// }
