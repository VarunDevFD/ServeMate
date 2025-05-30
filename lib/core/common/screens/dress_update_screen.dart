import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/models/dress_model.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_bloc.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/widgets/gender_selector_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';

class DressUpdatePage extends StatelessWidget {
  final DressModel item;
  final TextEditingController nameController;
  final TextEditingController genderController;
  final TextEditingController typeController;
  final TextEditingController sizeController;
  final TextEditingController colorController;
  final TextEditingController materialController;
  final TextEditingController brandController;
  final TextEditingController durationController;
  final TextEditingController priceController;
  final TextEditingController sdPriceController;
  final TextEditingController conditionController;
  final TextEditingController dateController;
  final TextEditingController phoneNumberController;
  final TextEditingController descriptionController;

  DressUpdatePage({super.key, required this.item})
      : nameController = TextEditingController(text: item.name),
        genderController = TextEditingController(text: item.gender),
        typeController = TextEditingController(text: item.type),
        sizeController = TextEditingController(text: item.size),
        colorController = TextEditingController(text: item.color),
        materialController = TextEditingController(text: item.material),
        brandController = TextEditingController(text: item.brand),
        durationController = TextEditingController(text: item.duration),
        priceController = TextEditingController(text: item.price.toString()),
        sdPriceController =
            TextEditingController(text: item.sdPrice.toString()),
        conditionController = TextEditingController(text: item.condition),
        dateController = TextEditingController(text: item.date),
        phoneNumberController = TextEditingController(text: item.phoneNumber),
        descriptionController = TextEditingController(text: item.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dress Update'),
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
          heroTag: 'dressUpdateFab',
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
          _buildTextField(genderController, 'Gender'),
          SizedBox(height: 16.h),
          _buildTextField(typeController, 'Type'),
          SizedBox(height: 16.h),
          _buildTextField(sizeController, 'Size'),
          SizedBox(height: 16.h),
          _buildTextField(colorController, 'Color'),
          SizedBox(height: 16.h),
          _buildTextField(materialController, 'Material'),
          SizedBox(height: 16.h),
          _buildTextField(brandController, 'Brand'),
          SizedBox(height: 16.h),
          _buildTextField(durationController, 'Duration'),
          SizedBox(height: 16.h),
          _buildTextField(priceController, 'Price'),
          SizedBox(height: 16.h),
          _buildTextField(sdPriceController, 'Security Deposit'),
          SizedBox(height: 16.h),
          _buildTextField(conditionController, 'Condition'),
          SizedBox(height: 16.h),
          _buildTextField(dateController, 'Date'),
          SizedBox(height: 16.h),
          _buildTextField(phoneNumberController, 'Phone Number'),
          SizedBox(height: 16.h),
          _buildTextField(descriptionController, 'Description'),
          SizedBox(height: 24.h),
          _buildLocationSection(),
          SizedBox(height: 24.h),
          _buildGenderSection(),
          SizedBox(height: 24.h),
          _buildTypeSection(),
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
          'Dress Location',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data: ${item.location[0]}',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        LocationTextField(),
      ],
    );
  }

  Widget _buildGenderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data: ${item.gender}',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          'Choose the Data to Update',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        const GenderSelectionWidget(),
      ],
    );
  }

  Widget _buildTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dress Type',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data: ${item.type}',
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
          onFieldSubmitted: (value) {
            typeController.text = value;
          },
          items: DropdownItems.categoriesDress,
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    final imageUrls = ImageConcatinate.concatinateImage(item.images);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dress Images',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data: Images',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(
          height: 180.h,
          width: 300.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(8.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: imageUrls[index],
                    width: 150.w,
                    height: 180.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8.h),
        const ImagePickerPage(),
      ],
    );
  }

  void _saveChanges(BuildContext context) async {
    final imagePickerBloc = context.read<ImagePickerBloc>();
    final locationBloc = context.read<LocationBloc>();
    final availableSwitchCubit = context.read<AvailableSwitchCubit>();
    final cubit = context.read<FilterChipCubit>();
    final selections = cubit.state.selections;

    final gender = selections['gender'] ?? [item.gender];
    final type = selections['type'] ?? [item.type];
    final isAvailable = availableSwitchCubit.state ?? item.available;

    List<String> location = item.location;
    final locationState = locationBloc.state;
    if (locationState is LocationLoaded) {
      location = locationState.location;
    }

    imagePickerBloc.add(UploadImagesToCloudinary());
    final stateImage = await imagePickerBloc.stream
        .firstWhere((state) => state is ImagesUploaded || state is ImageError);

    if (stateImage is ImagesUploaded) {
      final imageUrls = stateImage.imageUrls;
      imageUrls.removeAt(0);

      final updatedItem = item.copyWith(
        name: nameController.text,
        gender: gender.isNotEmpty ? gender[0] : item.gender,
        type: type.isNotEmpty ? type[0] : item.type,
        size: sizeController.text,
        color: colorController.text,
        material: materialController.text,
        brand: brandController.text,
        duration: durationController.text,
        price: int.tryParse(priceController.text) ?? item.price,
        sdPrice: int.tryParse(sdPriceController.text) ?? item.sdPrice,
        condition: conditionController.text,
        date: dateController.text,
        phoneNumber: phoneNumberController.text,
        description: descriptionController.text,
        images: [...item.images, ...imageUrls],
        location: location,
        available: isAvailable,
      );

      context
          .read<H2CategoryBloc>()
          .add(UpdateCategoryItemEvent(updatedItem, item.id, Names.dress));

      context.pop();
    }
  }
}
