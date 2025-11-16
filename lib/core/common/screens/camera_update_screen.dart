import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/common/bloc/switch_button_bloc/common_access_bloc/common_access_cubit.dart';
import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/constants.dart';

// Project imports
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/utils/dialog_utils.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart';
import 'package:serve_mate/core/utils/helper/image_helper.dart';
import 'package:serve_mate/core/widgets/dropdown_widget.dart';
import 'package:serve_mate/core/widgets/save_fab.dart';
import 'package:serve_mate/core/widgets/update_custom_text_field_widget.dart';
import 'package:serve_mate/core/widgets/update_facilities_section.dart';
import 'package:serve_mate/core/widgets/update_image_section.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_bloc.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
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
        phoneNumberController = TextEditingController(text: item.phoneNumber);

  @override
  Widget build(BuildContext context) {
    bool isStorage = false;
    bool isConnectivity = false;
    bool isAvailable = false;
    List<String> location = item.location;
    bool emptyImg = false;
    bool flag1 = false;
    bool flag2 = false;
    List<String> oldImg = [];
    List<String> newImg = [];
    return BlocProvider(
      create: (context) =>
          CommonCubit(ImageConcatinate.concatinateImage(item.images)),
      child: MultiBlocListener(
        listeners: [
          BlocListener<LocationBloc, LocationState>(
            listener: (context, state) {
              location = item.location;
              if (state is LocationLoaded) {
                location = state.location;
              }
            },
          ),
          BlocListener<CommonCubit, List<String>>(
            listener: (context, state) {
              final cubit = context.read<CommonCubit>();
              if (cubit.flag1) {
                flag1 = true;

                oldImg
                  ..clear()
                  ..addAll(ImageHelper.splitImg(state));
              }
              if (state.isEmpty) {
                emptyImg = true;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Select an image")),
                );
              }
            },
          ),
          BlocListener<ImagePickerBloc, ImageState>(
            listener: (context, state) async {
              emptyImg = false;
              if (state is UploadingImages) {
                flag2 = true;
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => Center(
                    child: LoadingAnimationWidget.discreteCircle(
                      color: AppColors.orange,
                      size: 50.r,
                      secondRingColor: AppColors.grey,
                      thirdRingColor: AppColors.white,
                    ),
                  ),
                );
              } else if (state is ImagesUploaded) {
                if (context.mounted) context.pop();
                flag2 = true;
                newImg.addAll(state.imageUrls);
              }
              // if (state is ImageError) context.pop();
            },
          ),
          BlocListener<AvailableSwitchCubit, bool>(
            listener: (context, state) {
              isAvailable = state;
            },
          ),
        ],
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildForm(context),
          floatingActionButton: _buildFloatingActionButton(
            context,
            isStorage,
            isConnectivity,
            isAvailable,
            emptyImg,
            location,
            flag1,
            flag2,
            oldImg,
            newImg,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  /// Builds the app bar with a back button and title
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Camera Update'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.read<ImagePickerBloc>().add(ClearAllImages());
          context.read<H2CategoryBloc>().add(InitialStageEvent());
          context.pop();
        },
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

  /// Builds the floating action button for saving changes
  Widget _buildFloatingActionButton(
    BuildContext context,
    bool isStorage,
    bool isConnectivity,
    bool isAvailable,
    bool emptyImg,
    List<String> location,
    bool flag1,
    bool flag2,
    List<String> oldImg,
    List<String> newImg,
  ) {
    return SaveFAB(
      onPressed: () {
        if (!emptyImg) {
          context.read<ImagePickerBloc>().add(SaveToCloudinary());
          DialogUtils.showStepDialog(
            mainTitle: 'Update Facilities',
            mainContent: 'Only taking new updates avoid previous data?',
            context: context,
            onConfirmed: () {
              if (oldImg.isEmpty) oldImg.addAll(item.images);
              isStorage = true;
              _saveChanges(
                context,
                isStorage,
                isConnectivity,
                isAvailable,
                location,
                flag1,
                flag2,
                oldImg,
                newImg,
              );
            },
            onSkip: () {
              if (oldImg.isEmpty) oldImg.addAll(item.images);
              _saveChanges(
                context,
                isStorage,
                isConnectivity,
                isAvailable,
                location,
                flag1,
                flag2,
                oldImg,
                newImg,
              );
            },
          );
        }
      },
    );
  }

  /// Builds all text fields for basic item details
  Widget _buildTextFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UpTextField(ctr: nameController, label: Names.name),
        SizedBox(height: 10.h),
        UpTextField(ctr: modelController, label: Names.model),
        SizedBox(height: 10.h),
        UpTextField(ctr: descriptionController, label: Names.description),
        SizedBox(height: 10.h),
        UpTextField(ctr: priceController, label: Names.price),
        SizedBox(height: 10.h),
        UpTextField(ctr: sdPriceController, label: Names.securityDeposit),
        SizedBox(height: 10.h),
        UpTextField(ctr: durationController, label: Names.duration),
        SizedBox(height: 10.h),
        UpTextField(ctr: phoneNumberController, label: Names.phoneNumber),
        CustomDropdownBuilder.build(
          labelText: item.brand ?? '${Names.brand} *',
          items: DropdownItems.brandsCamera,
          controller: brandController,
        ),
        CustomDropdownBuilder.build(
          labelText: item.category ?? '${Names.category} *',
          items: DropdownItems.categoriesCamera,
          controller: categoryController,
        ),
        CustomDropdownBuilder.build(
          labelText: item.condition ?? '${Names.condition} *',
          items: DropdownItems.condition,
          controller: conditionController,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  /// Builds additional sections (location, storage, connectivity, images)
  Widget _buildAdditionalSections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        LocationTextField(item.location[0]),
        SizedBox(height: 10.h),
        FacilitiesSection(
          id: 'storage',
          previousFacilities: item.storage,
          chipOptions: DropdownItems.storageOptionsCamera,
        ),
        SizedBox(height: 10.h),
        FacilitiesSection(
          id: 'connectivity',
          previousFacilities: item.connectivity,
          chipOptions: DropdownItems.connectivityOptionsCamera,
        ),
        SizedBox(height: 10.h),
        const ImageSection(),
      ],
    );
  }

  /// Saves the updated item data and navigates back
  void _saveChanges(
    BuildContext context,
    bool isStorage,
    bool isConnectivity,
    bool isAvailable,
    List<String> location,
    bool flag1,
    bool flag2,
    List<String> oldImages,
    List<String> newImages,
  ) async {
    List<String> images = [...item.images];

    if (flag1 && flag2) {
      images.clear();
      images = [...oldImages, ...newImages];
    } else if (!flag1 & flag2) {
      images.addAll(newImages);
    } else if (flag1 && !flag2) {
      images.clear();
      images.addAll(oldImages);
    }
    images = images.toSet().toList();
    final cubit = context.read<FilterChipCubit>();
    final selections = cubit.state.selections;
    final List<String> storage = isStorage
        ? List<String>.from(selections['storage'] ?? [])
        : [
            ...List<String>.from(selections['storage'] ?? []),
            ...item.storage ?? [],
          ];

    final List<String> connectivity = isConnectivity
        ? List<String>.from(selections['connectivity'] ?? [])
        : [
            ...List<String>.from(selections['connectivity'] ?? []),
            ...item.connectivity ?? [],
          ];

    if (flag1 && flag2) await Future.delayed(const Duration(seconds: 3));

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
      duration: durationController.text,
      phoneNumber: phoneNumberController.text,
      storage: storage,
      connectivity: connectivity,
      images: images,
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
