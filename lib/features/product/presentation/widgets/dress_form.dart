import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_state.dart';

class DressForm extends StatelessWidget {
  const DressForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFormHeader('Dress Type'),
        _buildGenderSelection(),
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
        _buildTextField('Enter color'),
        _buildFormHeader('Material'),
        _buildTextField('Enter material'),
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
        _buildFormHeader('Special Requests'),
        _buildTextField('Enter any special requests'),
        _buildFormHeader('Images'),
        // Placeholder for image upload functionality
        _buildFormHeader('Pickup/Delivery Option'),
        _buildTextField('Enter pickup or delivery option'),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Men'),
                value: 'Men',
                groupValue: state.selectedGender,
                onChanged: (value) {
                  context.read<DressFormBloc>().add(GenderSelected(value!));
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Girls'),
                value: 'Girls',
                groupValue: state.selectedGender,
                onChanged: (value) {
                  context.read<DressFormBloc>().add(GenderSelected(value!));
                },
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
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
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
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
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
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
