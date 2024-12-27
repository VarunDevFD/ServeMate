import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/features/product/presentation/bloc/dropdown_bloc/dropdown_bloc.dart';
import 'package:serve_mate/features/product/presentation/widgets/child_widget_calender.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_textfield_validator.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/location_text_field.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/venue_facilities_widget.dart';

class VenueForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController capacityController;
  final TextEditingController priceController;
  final TextEditingController securityController;
  final TextEditingController descriptionController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  final Function(String?) locationController;
  final Function(String?) onDurationSelected;
  final Function(String?) onTypeSelected;
  final Function(String?) dateController;
  final Function(List<String>?) onImageSelected;
  final void Function(String) selectedFacilities;

  const VenueForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.capacityController,
    required this.priceController,
    required this.securityController,
    required this.descriptionController,
    required this.phoneController,
    required this.emailController,
    required this.locationController,
    required this.onDurationSelected,
    required this.onTypeSelected,
    required this.dateController,
    required this.onImageSelected,
    required this.selectedFacilities,
  });

  @override
  Widget build(BuildContext context) {
    final dropdownBloc = DropdownBloc();
    final List<String> venueList = [...facilitiesVenue];

    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          _buildSection(
            title: 'Venue Name',
            child: CustomTextField(
              hint: 'Enter Venue Name',
              numberLimit: 20,
              controller: nameController,
              keyboardType: TextInputType.text,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter the Venue Name'
                  : null,
            ),
          ),
          _buildSection(
            title: 'Location',
            child: buildLocationTextField(
                context, 'Enter Location', locationController),
          ),
          _buildSection(
            title: 'Venue Capacity',
            child: CustomTextField(
              hint: 'Enter Venue Capacity',
              numberLimit: 6,
              controller: capacityController,
              keyboardType: TextInputType.number,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter the Venue Capacity'
                  : null,
            ),
          ),
          _buildSection(
            title: 'Rental Duration',
            child: Padding(
              padding: EdgeInsets.only(top: 8.0.h, bottom: 5.h),
              child: ReusableDropdown(
                onDataSelected: onDurationSelected,
                bloc: dropdownBloc,
                items: DropdownItems.rentalDurationItems,
                hint: "Duration",
              ),
            ),
          ),
          _buildSection(
            title: 'Rental Price',
            child: CustomTextField(
              hint: 'Enter rental price',
              keyboardType: TextInputType.number,
              maxLines: 1,
              numberLimit: 8,
              showSuffixIcon: true,
              controller: priceController,
              popupMessage:
                  'This field depends on the Rental Duration. Based on your selection, duration-based price will showcase here!',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the price';
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
              hint: 'Enter security deposit',
              numberLimit: 10,
              keyboardType: TextInputType.number,
              controller: securityController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the security deposit';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid deposit';
                }
                return null;
              },
            ),
          ),
          _buildSection(
            title: 'Venue Type',
            child: Padding(
              padding: EdgeInsets.only(top: 8.0.h, bottom: 5.h),
              child: ReusableDropdown(
                onDataSelected: onTypeSelected,
                bloc: dropdownBloc,
                items: DropdownItems.venueTypeItems,
                hint: "Venue Type",
              ),
            ),
          ),
          _buildSection(
            title: 'Available Date',
            child: buildCalender(context, dateController),
          ),
          _buildSection(
            title: 'Facilities Available',
            child: VenueFacilitiesWidget(
                facilities: venueList, selectedFacilities: selectedFacilities),
          ),
          _buildSection(
            title: 'Contact Number',
            child: CustomTextField(
              hint: 'Enter Phone Number',
              numberLimit: 10,
              controller: phoneController,
              keyboardType: TextInputType.phone,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter the Phone Number'
                  : null,
            ),
          ),
          _buildSection(
            title: 'Email',
            child: CustomTextField(
              hint: 'Enter Email',
              numberLimit: 50,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter the Email'
                  : null,
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
            title: 'Description',
            child: CustomTextField(
              hint: 'Enter any Description',
              keyboardType: TextInputType.text,
              controller: descriptionController,
              maxLines: 5,
            ),
          ),
          SizedBox(height: 50.h),
        ],
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
