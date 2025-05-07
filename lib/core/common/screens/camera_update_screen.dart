import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart'; 
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

class CameraUpdatePage extends StatelessWidget {
  final dynamic item;
  final TextEditingController nameController;
  final TextEditingController brandController;
  final TextEditingController modelController;
  final TextEditingController categoryController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController sdPriceController;
  final TextEditingController conditionController;
  final TextEditingController durationController;
  final TextEditingController phoneNumberController;
  final TextEditingController latePolicyController;

  CameraUpdatePage({super.key, required this.item})
      : nameController = TextEditingController(text: item?.name ?? ''),
        brandController = TextEditingController(text: item?.brand ?? ''),
        modelController = TextEditingController(text: item?.model ?? ''),
        categoryController = TextEditingController(text: item?.category ?? ''),
        descriptionController =
            TextEditingController(text: item?.description ?? ''),
        priceController =
            TextEditingController(text: item?.price?.toString() ?? ''),
        sdPriceController =
            TextEditingController(text: item?.sdPrice?.toString() ?? ''),
        conditionController =
            TextEditingController(text: item?.condition ?? ''),
        durationController = TextEditingController(text: item?.duration ?? ''),
        phoneNumberController =
            TextEditingController(text: item?.phoneNumber ?? ''),
        latePolicyController =
            TextEditingController(text: item?.latePolicy ?? '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Update'),
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
          heroTag: 'cameraUpdateFab',
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
          _buildTextField(brandController, 'Brand'),
          SizedBox(height: 16.h),
          _buildTextField(modelController, 'Model'),
          SizedBox(height: 16.h),
          _buildTextField(categoryController, 'Category'),
          SizedBox(height: 16.h),
          _buildTextField(descriptionController, 'Description'),
          SizedBox(height: 16.h),
          _buildTextField(priceController, 'Price'),
          SizedBox(height: 16.h),
          _buildTextField(sdPriceController, 'Security Deposit'),
          SizedBox(height: 16.h),
          ReusableDropdown(
            items: DropdownItems.condition,
            labelText: item.condition ?? 'Condition *',
            onFieldSubmitted: (value) {
              conditionController.text = value;
            },
          ),
          SizedBox(height: 16.h),
          _buildTextField(durationController, 'Duration'),
          SizedBox(height: 16.h),
          _buildTextField(phoneNumberController, 'Phone Number'),
          SizedBox(height: 16.h),
          _buildTextField(latePolicyController, 'Late Policy'),
          SizedBox(height: 24.h),
          _buildLocationSection(),
          SizedBox(height: 24.h),
          _buildStorageOptionsSection(),
          SizedBox(height: 24.h),
          _buildConnectivityOptionsSection(),
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
          'Camera Location',
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

  Widget _buildStorageOptionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Storage Options',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data:\n${item.storage?.join('\n') ?? 'No Storage'}',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          'Choose the Data to Update',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        FilterChipScreen(
          id: 'storage',
          categories: DropdownItems
              .storageOptionsCamera, // Assuming storageOptions is defined in constants_list.dart
        ),
      ],
    );
  }

  Widget _buildConnectivityOptionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connectivity Options',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data:\n${item.connectivity?.join('\n') ?? 'No Connectivity'}',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          'Choose the Data to Update',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        FilterChipScreen(
          id: 'connectivity',
          categories: DropdownItems
              .connectivityOptionsCamera, // Assuming connectivityOptions is defined in constants_list.dart
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Camera Images',
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

    final storage = selections['storage'] ?? item.storage;
    final connectivity = selections['connectivity'] ?? item.connectivity;
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
      brand: brandController.text,
      model: modelController.text,
      category: categoryController.text,
      description: descriptionController.text,
      price: int.tryParse(priceController.text) ?? item.price,
      sdPrice: int.tryParse(sdPriceController.text) ?? item.sdPrice,
      condition: conditionController.text,
      duration: durationController.text,
      phoneNumber: phoneNumberController.text,
      latePolicy: latePolicyController.text,
      storage: storage,
      connectivity: connectivity,
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
