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

class FootwearUpdatePage extends StatelessWidget {
  final dynamic item;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController sdPriceController;
  final TextEditingController descriptionController;
  final TextEditingController brandController;
  final TextEditingController conditionController;
  final TextEditingController colorController;
  final TextEditingController categoryController;
  final TextEditingController dateController;
  final TextEditingController phoneNumberController;

  FootwearUpdatePage({super.key, required this.item})
      : nameController = TextEditingController(text: item?.name ?? ''),
        priceController =
            TextEditingController(text: item?.price?.toString() ?? ''),
        sdPriceController =
            TextEditingController(text: item?.sdPrice?.toString() ?? ''),
        descriptionController =
            TextEditingController(text: item?.description ?? ''),
        brandController = TextEditingController(text: item?.brand ?? ''),
        conditionController =
            TextEditingController(text: item?.condition ?? ''),
        colorController = TextEditingController(text: item?.color ?? ''),
        categoryController = TextEditingController(text: item?.category ?? ''),
        dateController = TextEditingController(text: item?.date ?? ''),
        phoneNumberController =
            TextEditingController(text: item?.phoneNumber ?? '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Footwear Update'),
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
          heroTag: 'footwearUpdateFab',
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
          _buildTextField(brandController, 'Brand'),
          SizedBox(height: 16.h),
          _buildTextField(conditionController, 'Condition'),
          SizedBox(height: 16.h),
          _buildTextField(colorController, 'Color'),
          SizedBox(height: 16.h),
          _buildTextField(categoryController, 'Category'),
          SizedBox(height: 16.h),
          _buildTextField(phoneNumberController, 'Phone Number'),
          SizedBox(height: 24.h),
          _buildLocationSection(),
          SizedBox(height: 24.h),
          _buildSizeSection(),
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
          'Footwear Location',
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

  Widget _buildSizeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data:\n${item.size?.join('\n') ?? 'No Size'}',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          'Choose the Data to Update',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        FilterChipScreen(
          id: 'size',
          categories: sizeOfFootwear,
        ),
      ],
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Footwear Category',
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
        ReusableDropdown(
          labelText: 'Category*',
          items: DropdownItems.footwearTypes,
          onFieldSubmitted: (value) {
            categoryController.text = value;
          },
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Footwear Images',
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

    final size = selections['size'] ?? item.size;
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
      price: int.tryParse(priceController.text) ?? item.price,
      sdPrice: int.tryParse(sdPriceController.text) ?? item.sdPrice,
      description: descriptionController.text,
      brand: brandController.text,
      condition: conditionController.text,
      size: size,
      color: colorController.text,
      category: category.isNotEmpty ? category[0] : item.category,
      date: dateController.text,
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
