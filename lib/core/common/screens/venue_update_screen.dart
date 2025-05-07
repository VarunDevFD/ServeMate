import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_bloc.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';

class VenueUpdatePage extends StatelessWidget {
  final dynamic item;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController sdPriceController;
  final TextEditingController descriptionController;
  final TextEditingController capacityController;
  final TextEditingController durationController;
  final TextEditingController venueTypeController;
  final TextEditingController phoneNumberController;

  VenueUpdatePage({super.key, required this.item})
      : nameController = TextEditingController(text: item?.name ?? ''),
        priceController =
            TextEditingController(text: item?.price?.toString() ?? ''),
        sdPriceController =
            TextEditingController(text: item?.sdPrice?.toString() ?? ''),
        descriptionController =
            TextEditingController(text: item?.description ?? ''),
        capacityController =
            TextEditingController(text: item?.capacity?.toString() ?? ''),
        durationController = TextEditingController(text: item?.duration ?? ''),
        venueTypeController =
            TextEditingController(text: item?.venueType ?? ''),
        phoneNumberController =
            TextEditingController(text: item?.phoneNumber ?? '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venue Update'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<H2CategoryBloc>().add(H2LoadCategories());
            context.pop();
          },
        ),
      ),
      body: _buildForm(context),
      floatingActionButton: SizedBox(
        width: 60.w,
        height: 60.h,
        child: FloatingActionButton(
          onPressed: () => _saveChanges(context),
          elevation: 0,
          highlightElevation: 0,
          mini: false,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          shape: const CircleBorder(),
          heroTag: 'venueUpdateFab',
          child: Icon(
            Icons.save,
            size: 26.sp,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(nameController, 'Name'),
          SizedBox(height: 16.h),
          _buildTextField(priceController, 'Price'),
          SizedBox(height: 16.h),
          _buildTextField(sdPriceController, 'Security Deposit'),
          SizedBox(height: 16.h),
          _buildTextField(descriptionController, 'Description'),
          SizedBox(height: 16.h),
          _buildTextField(capacityController, 'Capacity'),
          SizedBox(height: 16.h),
          _buildTextField(durationController, 'Duration'),
          SizedBox(height: 16.h),
          _buildTextField(venueTypeController, 'Venue Type'),
          SizedBox(height: 16.h),
          _buildTextField(phoneNumberController, 'Phone Number'),
          SizedBox(height: 24.h),
          _buildLocationSection(),
          SizedBox(height: 24.h),
          ReusableDropdown(
            labelText: item.type ?? 'Duration *',
            items: DropdownItems.rentalDurationItems,
            onFieldSubmitted: (value) {
              durationController.text = value;
            },
          ),
          SizedBox(height: 24.h),
          ReusableDropdown(
            labelText: item.venueType ?? 'Venue Type *',
            items: DropdownItems.venueTypeItems,
            onFieldSubmitted: (value) {
              venueTypeController.text = value;
            },
          ),
          SizedBox(height: 24.h),
          _buildFacilitiesSection(),
          SizedBox(height: 24.h),
          _buildImageSection(),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Venue Location',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data: ${item.location[0] ?? 'No Location'}',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        LocationTextField(),
      ],
    );
  }

  Widget _buildFacilitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Facilities',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data:\n${item.facilities?.join('\n') ?? 'No Facilities'}',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          'Choose the Data to Update',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        FilterChipScreen(
          id: 'facilities',
          categories:
              facilitiesVenue, // Assuming venueFacilitiesOptions is defined in constants_list.dart
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Venue Images',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data: Images',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        const ImagePickerPage(),
      ],
    );
  }

  void _saveChanges(BuildContext context) {
    final imagePickerBloc = context.read<ImagePickerBloc>();
    final locationBloc = context.read<LocationBloc>();
    final availableSwitchCubit = context.read<AvailableSwitchCubit>();
    final cubit = context.read<FilterChipCubit>();
    final selections = cubit.state.selections;
    final facilities = selections['facilities'] ?? item.facilities;
    final currentImageState = imagePickerBloc.state;
    final isAvailable = availableSwitchCubit.state ?? item.available;

    List<String> images = item.images;
    // if (currentImageState is ImageLoaded) {
    //   images = currentImageState.images;
    // }

    List<String> location = item.location;
    final locationState = locationBloc.state;
    if (locationState is LocationLoaded) {
      location = locationState.location;
    }

    final updatedItem = item.copyWith(
      name: nameController.text,
      price: int.tryParse(priceController.text) ?? item.price,
      sdPrice: int.tryParse(sdPriceController.text) ?? item.sdPrice,
      description: descriptionController.text,
      capacity: int.tryParse(capacityController.text) ?? item.capacity,
      duration: durationController.text,
      venueType: venueTypeController.text,
      phoneNumber: phoneNumberController.text,
      facilities: facilities,
      images: images,
      location: location,
      available: isAvailable,
    );

    context
        .read<H2CategoryBloc>()
        .add(UpdateCategoryItemEvent(updatedItem, item.id));

    context.pop();
  }
}
