import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/core/utils/constants.dart';

// Project imports
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart';
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
  final CameraModel item;

  // Controllers for text fields
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
      : nameController = TextEditingController(text: item.name),
        brandController = TextEditingController(text: item.brand),
        modelController = TextEditingController(text: item.model),
        categoryController = TextEditingController(text: item.category),
        descriptionController = TextEditingController(text: item.description),
        priceController = TextEditingController(text: item.price.toString()),
        sdPriceController =
            TextEditingController(text: item.sdPrice.toString()),
        conditionController = TextEditingController(text: item.condition),
        durationController = TextEditingController(text: item.duration),
        phoneNumberController = TextEditingController(text: item.phoneNumber),
        latePolicyController = TextEditingController(text: item.latePolicy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildForm(context),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// Builds the app bar with a back button and title
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Camera Update'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.read<H2CategoryBloc>().add(InitialStageEvent());
          context.pop();
        },
      ),
    );
  }

  /// Builds the floating action button for saving changes
  Widget _buildFloatingActionButton(BuildContext context) {
    return SizedBox(
      width: 60.w,
      height: 60.h,
      child: FloatingActionButton(
        onPressed: () => _saveChanges(context),
        elevation: 0,
        highlightElevation: 0,
        shape: const CircleBorder(),
        heroTag: 'cameraUpdateFab',
        child: Icon(Icons.save, size: 26.sp),
      ),
    );
  }

  /// Builds the main form within a scrollable view
  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTextFields(),
          _buildAdditionalSections(context),
          SizedBox(height: 60.h), // Space for FAB
        ],
      ),
    );
  }

  /// Builds all text fields for basic item details
  Widget _buildTextFields() {
    return Column(
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
        _buildTextField(priceController, 'Price',
            keyboardType: TextInputType.number),
        SizedBox(height: 16.h),
        _buildTextField(sdPriceController, 'Security Deposit',
            keyboardType: TextInputType.number),
        SizedBox(height: 16.h),
        ReusableDropdown(
          items: DropdownItems.condition,
          labelText: item.condition,
          onFieldSubmitted: (value) => conditionController.text = value,
        ),
        SizedBox(height: 16.h),
        _buildTextField(durationController, 'Duration'),
        SizedBox(height: 16.h),
        _buildTextField(phoneNumberController, 'Phone Number',
            keyboardType: TextInputType.phone),
        SizedBox(height: 16.h),
        _buildTextField(latePolicyController, 'Late Policy'),
      ],
    );
  }

  /// Builds additional sections (location, storage, connectivity, images)
  Widget _buildAdditionalSections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        _buildLocationSection(),
        SizedBox(height: 24.h),
        _buildStorageOptionsSection(),
        SizedBox(height: 24.h),
        _buildConnectivityOptionsSection(),
        SizedBox(height: 24.h),
        _buildImageSection(context),
      ],
    );
  }

  /// Builds a reusable text field with consistent styling
  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  /// Builds the section for camera location
  Widget _buildLocationSection() {
    return _buildSection(
      title: 'Camera Location',
      children: [
        Text(
          'Previous Data: ${item.location.isNotEmpty ? item.location[0] : 'No Location'}',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        LocationTextField(),
      ],
    );
  }

  /// Builds the section for storage options
  Widget _buildStorageOptionsSection() {
    return _buildSection(
      title: 'Storage Options',
      children: [
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
          categories: DropdownItems.storageOptionsCamera,
        ),
      ],
    );
  }

  /// Builds the section for connectivity options
  Widget _buildConnectivityOptionsSection() {
    return _buildSection(
      title: 'Connectivity Options',
      children: [
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
          categories: DropdownItems.connectivityOptionsCamera,
        ),
      ],
    );
  }

  /// Builds the section for camera images
  Widget _buildImageSection(BuildContext context) {
    final imageUrls = ImageConcatinate.concatinateImage(item.images);

    return _buildSection(
      title: 'Camera Images',
      children: [
        const Text('Previous Data: Images'),
        SizedBox(height: 8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
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
            ),
            SizedBox(width: 8.w),
            // Expanded(
            //   flex: 1,
            //   child: SizedBox(
            //     width: 100.w, // Fixed width for the button
            //     height: 180.h, // Matches ListView height
            //     child: Center(
            //       child: BlocBuilder<CommonBloc, CommonState>(
            //         builder: (context, state) {
            //           bool btn = true;

            //           if (state is AccessState) {
            //             btn = state.btn;
            //           }
            //           return TextButton(
            //             onPressed: () {
            //               context.read<CommonBloc>().add(AccessSwitch());
            //             },
            //             style: TextButton.styleFrom(
            //               backgroundColor:
            //                   (btn) ? AppColors.dimOrange : AppColors.dimGreen,
            //               padding: EdgeInsets.symmetric(
            //                   horizontal: 16.w, vertical: 12.h),
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(8),
            //               ),
            //             ),
            //             child: Text(
            //               btn ? 'Add previous image' : 'Added',
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                 color: btn ? AppColors.orange : AppColors.green,
            //                 fontSize: 10.sp,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        const ImagePickerPage(),
      ],
    );
  }

  /// Reusable method to build a section with a title and children
  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        ...children,
      ],
    );
  }

  /// Saves the updated item data and navigates back
  void _saveChanges(BuildContext context) async {
    final imagePickerBloc = context.read<ImagePickerBloc>();
    final locationBloc = context.read<LocationBloc>();
    final availableSwitchCubit = context.read<AvailableSwitchCubit>();
    final cubit = context.read<FilterChipCubit>();

    // Get selections from FilterChipCubit
    final selections = cubit.state.selections;
    final storage = selections['storage'] ?? item.storage;
    final connectivity = selections['connectivity'] ?? item.connectivity;

    // Get availability state
    final isAvailable = availableSwitchCubit.state ?? item.available;

    imagePickerBloc.add(UploadImagesToCloudinary());
    final stateImage = await imagePickerBloc.stream
        .firstWhere((state) => state is ImagesUploaded || state is ImageError);

    if (stateImage is ImagesUploaded) {
      final imageUrls = stateImage.imageUrls;
      imageUrls.removeAt(0);

      // Handle location
      List<String> location = item.location;
      final locationState = locationBloc.state;
      if (locationState is LocationLoaded) {
        location = locationState.location;
      }

      // Create updated item
      final updatedItem = item.copyWith(
        name: nameController.text.isNotEmpty ? nameController.text : item.name,
        brand:
            brandController.text.isNotEmpty ? brandController.text : item.brand,
        model:
            modelController.text.isNotEmpty ? modelController.text : item.model,
        category: categoryController.text.isNotEmpty
            ? categoryController.text
            : item.category,
        description: descriptionController.text.isNotEmpty
            ? descriptionController.text
            : item.description,
        price: int.tryParse(priceController.text) ?? item.price,
        sdPrice: int.tryParse(sdPriceController.text) ?? item.sdPrice,
        condition: conditionController.text.isNotEmpty
            ? conditionController.text
            : item.condition,
        duration: durationController.text.isNotEmpty
            ? durationController.text
            : item.duration,
        phoneNumber: phoneNumberController.text.isNotEmpty
            ? phoneNumberController.text
            : item.phoneNumber,
        latePolicy: latePolicyController.text.isNotEmpty
            ? latePolicyController.text
            : item.latePolicy,
        storage: storage,
        connectivity: connectivity,
        images: [...item.images, ...imageUrls],
        location: location,
        available: isAvailable,
      );

      // Update item and navigate back
      context
          .read<H2CategoryBloc>()
          .add(UpdateCategoryItemEvent(updatedItem, item.id, Names.camera));
      context.pop();
    }
  }
}
