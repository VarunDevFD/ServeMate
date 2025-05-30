import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/common/bloc/switch_button_bloc/common_access_bloc/common_access_cubit.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/core/utils/dialog_utils.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart';
import 'package:serve_mate/core/utils/helper/image_helper.dart';
import 'package:serve_mate/core/utils/helper/text_field_helper.dart';
import 'package:serve_mate/core/utils/image_handler.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_bloc.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_event.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_state.dart';
import 'package:serve_mate/features/naviaton/presentation/cubit/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
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
    bool isFacilities = false;
    bool isAvailable = false;
    List<String>? updatedImages;
    List<String> location = item.location;
    return BlocProvider(
      create: (context) =>
          CommonCubit(ImageConcatinate.concatinateImage(item.images)),
      child: BlocListener<LocationBloc, LocationState>(
        listener: (context, state) {
          location = item.location;
          if (state is LocationLoaded) {
            location = state.location;
          }
        },
        child: BlocListener<CommonCubit, List<String>>(
          listener: (context, state) {
            updatedImages = state;
          },
          child: BlocListener<ImagePickerBloc, ImageState>(
            listener: (context, state) async {
              List<File>? data;
              if (state is ImageLoaded) {
                data = state.images;
              } else if (state is ReadyToSave) {
                List<String>? imageUrls = ImageHelper.fileToString(data!);
                final imagePath =
                    await ImageHandler().processAndUploadImages(imageUrls);

                updatedImages = imagePath;
              }
            },
            child: BlocListener<AvailableSwitchCubit, bool>(
              listener: (context, state) {
                isAvailable = state;
              },
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Venue Update'),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.read<ImagePickerBloc>().add(ClearAllImages());
                      context.read<H2CategoryBloc>().add(InitialStageEvent());
                      context.pop();
                    },
                  ),
                ),
                body: _buildForm(context),
                floatingActionButton: SizedBox(
                  width: 60.w,
                  height: 60.h,
                  child: FloatingActionButton(
                    onPressed: () {
                      updatedImages ??= item.images;
                      log("----------------------------");
                      log("Updated Images: $updatedImages");
                      log("----------------------------");

                      DialogUtils.showStepDialog(
                        mainTitle: 'Update Facilities',
                        mainContent:
                            'Only taking new updates void prvious data?',
                        context: context,
                        onConfirmed: () {
                          isFacilities = true;
                          _saveChanges(context, isFacilities, isAvailable,
                              location, updatedImages);
                        },
                        onSkip: () {
                          isFacilities = false;
                          _saveChanges(context, isFacilities, isAvailable,
                              location, updatedImages);
                        },
                      );
                    },
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
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.r),
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
          _buildTextField(phoneNumberController, 'Phone Number'),
          SizedBox(height: 24.h),
          _buildLocationSection(),
          SizedBox(height: 24.h),
          ReusableDropdown(
            labelText: item.duration ?? 'Duration *',
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
          SizedBox(height: 16.h),
          const SwitchTileScreen(),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      maxLength: TextFieldHelper.getMaxLengthForLabel(label),
      keyboardType: TextFieldHelper.getKeyboardTypeForLabel(label),
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
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        Text(
          'Choose the Data to Update',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        FilterChipScreen(id: 'facilities', categories: facilitiesVenue),
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
        BlocBuilder<CommonCubit, List<String>>(
          builder: (context, imageUrls) {
            if (imageUrls.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Icon(Icons.image_not_supported,
                        size: 50.sp, color: AppColors.grey),
                    SizedBox(height: 10.h),
                    Text(
                      'No images available Add Images',
                      style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
                    ),
                  ],
                ),
              );
            }
            return SizedBox(
              height: 180.h,
              width: 300.w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  final bloc = context.read<CommonCubit>();
                  return Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ImageHelper.updateCachedNetworkImage(
                            imageUrl: imageUrls[index],
                          ),
                        ),
                        Positioned(
                          top: 4.h,
                          right: 4.w,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.close,
                                  color: AppColors.white, size: 18.sp),
                              onPressed: () => bloc.removeImage(index),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
        SizedBox(height: 8.h),
        const ImagePickerPage(),
      ],
    );
  }

  void _saveChanges(BuildContext context, bool isFacilities, bool isAvailable,
      List<String> location, List<String>? updatedImages) async {
    context.read<ImagePickerBloc>().add(ReadyToSaveEvent());
    final cubit = context.read<FilterChipCubit>();
    final selections = cubit.state.selections;
    final dynamic facilities;

    if (isFacilities) {
      facilities = selections['facilities'];
    } else {
      facilities = [selections['facilities'], ...item.facilities];
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
      images: updatedImages ?? item.images,
      location: location,
      available: isAvailable,
    );

    context
        .read<H2CategoryBloc>()
        .add(UpdateCategoryItemEvent(updatedItem, item.id, Names.venue));

    context.pop();
  }
}
// 310 -> 372 -> 372
