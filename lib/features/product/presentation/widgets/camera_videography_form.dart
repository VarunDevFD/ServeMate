import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/features/product/presentation/bloc/dropdown_bloc/dropdown_bloc.dart';
import 'package:serve_mate/features/product/presentation/widgets/child_widget_calender.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_textfield_validator.dart';
import 'package:serve_mate/features/product/presentation/widgets/location_text_field.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';

class CameraVideographyForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController rentalPriceController;
  final TextEditingController securityDepositController;
  final Function(String?) onConditionSelected;
  final Function(String?) dateController;
  final TextEditingController accessoriesController;
  final TextEditingController pickupOptionController;
  final TextEditingController insuranceController;
  final TextEditingController notesController;

  final Function(List<String>?) onImageSelected;
  final Function(String?) onTypeSelected;
  final Function(String?) onBrandSelected;
  final Function(String?) locationController;

  const CameraVideographyForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.onTypeSelected,
    required this.onBrandSelected,
    required this.rentalPriceController,
    required this.securityDepositController,
    required this.onConditionSelected,
    required this.dateController,
    required this.accessoriesController,
    required this.pickupOptionController,
    required this.insuranceController,
    required this.notesController,
    required this.onImageSelected,
    required this.locationController,
  });

  @override
  Widget build(BuildContext context) {
    final cameraType = DropdownBloc<String>();
    final cameraBrand = DropdownBloc<String>();
    final cameraCondition = DropdownBloc<String>();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSection(
          title: 'Camera Type',
          child: CustomTextField(
            hint: 'Enter Camera Type',
            numberLimit: 20,
            controller: nameController,
            keyboardType: TextInputType.text,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter the Camera Type'
                : null,
          ),
        ),
        _buildSection(
          title: 'Camera Type',
          child: ReusableDropdown(
              bloc: cameraType,
              items: const [
                "Photography",
                "Videography",
                "Action",
                "Specialized",
                "Hybrid",
              ],
              hint: 'Enter Equipment Type (e.g., Camera, Lens, Gimbal)',
              onDataSelected: onTypeSelected),
        ),
        _buildSection(
          title: 'Brand/Model',
          child: ReusableDropdown(
            bloc: cameraBrand,
            items: const [
              "Blackmagic Design",
              "Canon",
              "DJI",
              "Fujifilm",
              "GoPro",
              "Hasselblad",
              "InstaX (Fujifilm)",
              "Kodak",
              "Leica",
              "Nikon",
              "Olympus (OM System)",
              "Panasonic (Lumix)",
              "Pentax",
              "Polaroid",
              "Phase One",
              "Red Digital Cinema",
              "Ricoh",
              "Sigma",
              "Sony",
              "Z Cam",
            ],
            hint: 'Choose an Camera Brand',
            onDataSelected: onBrandSelected,
          ),
        ),
        _buildSection(
          title: 'Rental Price (Per Day)',
          child: CustomTextField(
            hint: 'Enter Rental Price Per Day',
            numberLimit: 6,
            controller: rentalPriceController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Rental Price';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
        ),
        _buildSection(
          title: 'Security Deposit',
          child: CustomTextField(
            hint: 'Enter Security Deposit Amount',
            numberLimit: 6,
            controller: securityDepositController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Security Deposit';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid deposit';
              }
              return null;
            },
          ),
        ),
        _buildSection(
          title: 'Condition',
          child: ReusableDropdown(
            onDataSelected: onConditionSelected,
            bloc: cameraCondition,
            items: const ['New', 'Like New', 'Good'],
            hint: "Condition",
          ),
        ),
        _buildSection(
          title: 'Available Date',
          child: buildCalender(context, dateController),
        ),
        _buildSection(
          title: 'Accessories Included',
          child: CustomTextField(
            hint: 'List Any Included Accessories (e.g., Tripod, Memory Card)',
            numberLimit: 100,
            controller: accessoriesController,
            keyboardType: TextInputType.text,
          ),
        ),
        _buildSection(
          title: 'Images',
          child: ImagePickerFormField(
            onSaved: onImageSelected,
            validator: (images) => images == null || images.isEmpty
                ? 'Please select at least one image.'
                : null,
          ),
        ),
        _buildSection(
          title: 'Pickup/Location Option',
          child: buildLocationTextField(context, 'Enter Location', locationController),
        ),
        _buildSection(
          title: 'Damage policy',
          child: CustomTextField(
            hint: 'Enter the damage policy',
            maxLines: 5,
            controller: insuranceController,
            keyboardType: TextInputType.text,
          ),
        ),
        _buildSection(
          title: 'Notes or Additional Information',
          child: CustomTextField(
            hint: 'Enter Any Additional Notes',
            keyboardType: TextInputType.text,
            controller: notesController,
            maxLines: 5,
          ),
        ),
        SizedBox(height: 50.h),
      ],
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
