import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';

class SoundUpdatePage extends StatelessWidget {
  final dynamic item;
  final TextEditingController nameController;
  final TextEditingController categoryController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController securityDepositController;
  final TextEditingController phoneNumberController;

  SoundUpdatePage({super.key, required this.item})
      : nameController = TextEditingController(text: item?.name ?? ''),
        categoryController = TextEditingController(text: item?.category ?? ''),
        descriptionController =
            TextEditingController(text: item?.description ?? ''),
        priceController =
            TextEditingController(text: item?.price?.toString() ?? ''),
        securityDepositController = TextEditingController(
            text: item?.securityDeposit?.toString() ?? ''),
        phoneNumberController =
            TextEditingController(text: item?.phoneNumber ?? '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sound System Update'),
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
          heroTag: 'soundUpdateFab',
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
          _buildTextField(categoryController, 'Category'),
          SizedBox(height: 16.h),
          _buildTextField(descriptionController, 'Description'),
          SizedBox(height: 16.h),
          _buildTextField(priceController, 'Price'),
          SizedBox(height: 16.h),
          _buildTextField(securityDepositController, 'Security Deposit'),
          SizedBox(height: 16.h),
          _buildTextField(phoneNumberController, 'Phone Number'),
          SizedBox(height: 24.h),
          _buildLocationSection(),
          SizedBox(height: 24.h),
          _buildEquipmentTypesSection(),
          SizedBox(height: 24.h),
          _buildCategorySection(),
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
          'Sound System Location',
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

  Widget _buildEquipmentTypesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Equipment Types',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data:\n${item.equipmentTypes?.join('\n') ?? 'No Equipment Types'}',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          'Choose the Data to Update',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        // FilterChipScreen(
        //   id: 'equipmentTypes',
        //   categories: soundEquipmentOptions, // Assuming soundEquipmentOptions is defined in constants_list.dart
        // ),
      ],
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sound System Category',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data: ${item.category ?? 'No Category'}',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          'Choose the Data to Update',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        // FilterChipScreen(
        //   id: 'category',
        //   categories: soundCategoryOptions, // Assuming soundCategoryOptions is defined in constants_list.dart
        // ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sound System Images',
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

    final equipmentTypes = selections['equipmentTypes'] ?? item.equipmentTypes;
    final category = selections['category'] ?? [item.category];
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
      category: category.isNotEmpty ? category[0] : item.category,
      equipmentTypes: equipmentTypes,
      description: descriptionController.text,
      price: int.tryParse(priceController.text) ?? item.price,
      securityDeposit:
          int.tryParse(securityDepositController.text) ?? item.securityDeposit,
      phoneNumber: phoneNumberController.text,
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
