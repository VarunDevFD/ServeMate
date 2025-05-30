import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';

class JewelryUpdatePage extends StatelessWidget {
  final dynamic item;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController securityDepositController;
  final TextEditingController descriptionController;
  final TextEditingController typeController;
  final TextEditingController materialController;
  final TextEditingController quantityController;
  final TextEditingController conditionController;
  final TextEditingController brandController;
  final TextEditingController phoneNumberController;

  JewelryUpdatePage({super.key, required this.item})
      : nameController = TextEditingController(text: item?.name ?? ''),
        priceController =
            TextEditingController(text: item?.price?.toString() ?? ''),
        securityDepositController = TextEditingController(
            text: item?.securityDeposit?.toString() ?? ''),
        descriptionController =
            TextEditingController(text: item?.description ?? ''),
        typeController = TextEditingController(text: item?.type ?? ''),
        materialController = TextEditingController(text: item?.material ?? ''),
        quantityController = TextEditingController(text: item?.quantity ?? ''),
        conditionController =
            TextEditingController(text: item?.condition ?? ''),
        brandController = TextEditingController(text: item?.brand ?? ''),
        phoneNumberController =
            TextEditingController(text: item?.phoneNumber ?? '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jewelry Update')),
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
          heroTag: 'jewelryUpdateFab',
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
          _buildTextField(securityDepositController, 'Security Deposit'),
          SizedBox(height: 16.h),
          _buildTextField(descriptionController, 'Description'),
          SizedBox(height: 16.h),
          _buildTextField(quantityController, 'Quantity'),
          SizedBox(height: 16.h),
          _buildTextField(conditionController, 'Condition'),
          SizedBox(height: 16.h),
          _buildTextField(brandController, 'Brand'),
          SizedBox(height: 16.h),
          _buildTextField(phoneNumberController, 'Phone Number'),
          SizedBox(height: 24.h),
          ReusableDropdown(
            labelText: item.type ?? 'Type*',
            items: DropdownItems.jewelryTypes,
            onFieldSubmitted: (value) {
              typeController.text = value;
            },
          ),
          SizedBox(height: 16.h),
          ReusableDropdown(
            labelText: item.material ?? 'Category*',
            items: DropdownItems.jewelryCategorys,
            onFieldSubmitted: (value) {
              materialController.text = value;
            },
          ),
          SizedBox(height: 16.h),
          _buildLocationSection(),
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
          'Jewelry Location',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data: ${item.location?[0] ?? 'No Location'}',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        LocationTextField(),
      ],
    );
  }

  Widget _buildImageSection() {
    final imageUrls = ImageConcatinate.concatinateImage(item.images);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jewelry Images',
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

    final type = selections['type'] ?? [item.type];
    final material = selections['material'] ?? [item.material];
    final isAvailable = availableSwitchCubit.state ?? item.available;

    List<String> location = item.location ?? [];
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
        price: int.tryParse(priceController.text) ?? item.price,
        securityDeposit: int.tryParse(securityDepositController.text) ??
            item.securityDeposit,
        description: descriptionController.text,
        type: type.isNotEmpty ? type[0] : item.type,
        material: material.isNotEmpty ? material[0] : item.material,
        quantity: quantityController.text,
        condition: conditionController.text,
        brand: brandController.text,
        phoneNumber: phoneNumberController.text,
        images: [...item.images, ...imageUrls],
        location: location,
        available: isAvailable,
      );

      context
          .read<H2CategoryBloc>()
          .add(UpdateCategoryItemEvent(updatedItem, item.id, Names.jewelry));

      context.pop();
    }
  }
}
