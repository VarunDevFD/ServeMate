import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/widgets/save_fab.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/dialog_utils.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/core/widgets/dropdown_widget.dart';
import 'package:serve_mate/core/utils/helper/image_helper.dart';
import 'package:serve_mate/core/widgets/update_image_section.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart';
import 'package:serve_mate/core/widgets/update_facilities_section.dart';
import 'package:serve_mate/core/widgets/update_custom_text_field_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_bloc.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';
import 'package:serve_mate/core/common/bloc/switch_button_bloc/common_access_bloc/common_access_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';

class VehicleUpdatePage extends StatelessWidget {
  final dynamic item;
  final TextEditingController nameController;
  final TextEditingController modelController;
  final TextEditingController brandController;
  final TextEditingController typeController;
  final TextEditingController priceController;
  final TextEditingController vehicleTypeController;
  final TextEditingController sdController;
  final TextEditingController seatCapacityController;
  final TextEditingController regController;
  final TextEditingController fuelTypeController;
  final TextEditingController transmissionController;
  final TextEditingController dateController;
  final TextEditingController colorController;
  final TextEditingController descriptionController;

  VehicleUpdatePage({super.key, required this.item})
      : nameController = TextEditingController(text: item?.name ?? ''),
        modelController = TextEditingController(text: item?.model ?? ''),
        brandController = TextEditingController(text: item?.brand ?? ''),
        typeController = TextEditingController(),
        priceController =
            TextEditingController(text: item?.price?.toString() ?? ''),
        vehicleTypeController =
            TextEditingController(text: item?.vehicleType ?? ''),
        sdController = TextEditingController(
            text: item?.securityDeposit?.toString() ?? ''),
        seatCapacityController =
            TextEditingController(text: item?.seatCapacity?.toString() ?? ''),
        regController =
            TextEditingController(text: item?.registrationNumber ?? ''),
        fuelTypeController = TextEditingController(text: item?.fuelType ?? ''),
        transmissionController =
            TextEditingController(text: item?.transmission ?? ''),
        dateController = TextEditingController(text: item?.date ?? ''),
        colorController = TextEditingController(text: item?.color ?? ''),
        descriptionController =
            TextEditingController(text: item?.description ?? '');

  @override
  Widget build(BuildContext context) {
    bool isFacilities = false;
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
          floatingActionButton: SaveFAB(
            onPressed: () {
              if (!emptyImg) {
                context.read<ImagePickerBloc>().add(SaveToCloudinary());
                DialogUtils.showStepDialog(
                  mainTitle: 'Update Facilities',
                  mainContent: 'Only taking new updates avoid previous data?',
                  context: context,
                  onConfirmed: () {
                    if (oldImg.isEmpty) oldImg.addAll(item.images);
                    isFacilities = true;
                    _saveChanges(
                      context,
                      isFacilities,
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
                    isFacilities = false;
                    _saveChanges(
                      context,
                      isFacilities,
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
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Vehicle Update'),
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

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpTextField(ctr: nameController, label: Names.name),
          SizedBox(height: 16.h),
          UpTextField(ctr: brandController, label: Names.brand),
          SizedBox(height: 16.h),
          UpTextField(ctr: priceController, label: Names.price),
          SizedBox(height: 16.h),
          UpTextField(ctr: sdController, label: Names.securityDeposit),
          SizedBox(height: 16.h),
          UpTextField(ctr: seatCapacityController, label: Names.seatCapacity),
          SizedBox(height: 16.h),
          UpTextField(ctr: regController, label: Names.vehicleRegNumber),
          SizedBox(height: 16.h),
          UpTextField(ctr: colorController, label: Names.color),
          SizedBox(height: 16.h),
          UpTextField(ctr: descriptionController, label: Names.decoration),
          SizedBox(height: 24.h),
          LocationTextField(item.location[0]),
          CustomDropdownBuilder.build(
            labelText: item.vehicleType ?? '${Names.vehicleType} *',
            items: DropdownItems.vehicleTypeItems,
            controller: vehicleTypeController,
          ),
          CustomDropdownBuilder.build(
            labelText: item.model ?? '${Names.vehicleN} ${Names.model} *',
            items: DropdownItems.vehicleModelItems,
            controller: modelController,
          ),
          CustomDropdownBuilder.build(
            labelText: item.fuelType ?? '${Names.vehiclefuelType} *',
            items: DropdownItems.vehicleFuelItems,
            controller: fuelTypeController,
          ),
          CustomDropdownBuilder.build(
            labelText: item.transmission ?? '${Names.vehicleTransmission} *',
            items: DropdownItems.vehicleTransmissionItems,
            controller: transmissionController,
          ),
          SizedBox(height: 10.h),
          const SwitchTileScreen(),
          SizedBox(height: 10.h),
          FacilitiesSection(
            id: 'facilities',
            previousFacilities: item.facilities,
            chipOptions: facilitiesVehicle,
          ),
          SizedBox(height: 24.h),
          const ImageSection(),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }

  void _saveChanges(
    BuildContext context,
    bool isFacilities,
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
    final dynamic facilities;

    (isFacilities)
        ? facilities = selections['facilities']
        : facilities = [selections['facilities'], ...item.facilities];
    if (flag1 && flag2) await Future.delayed(const Duration(seconds: 3));

    final updatedItem = item.copyWith(
      name: nameController.text,
      model: modelController.text,
      brand: brandController.text,
      price: int.tryParse(priceController.text) ?? item.price,
      vehicleType: vehicleTypeController.text,
      securityDeposit: int.tryParse(sdController.text) ?? item.securityDeposit,
      seatCapacity:
          int.tryParse(seatCapacityController.text) ?? item.seatCapacity,
      registrationNumber: regController.text,
      fuelType: fuelTypeController.text,
      transmission: transmissionController.text,
      facilities: facilities,
      date: dateController.text,
      color: colorController.text,
      description: descriptionController.text,
      images: images,
      location: location,
      availability: isAvailable,
    );

    context
        .read<H2CategoryBloc>()
        .add(UpdateCategoryItemEvent(updatedItem, item.id, Names.vehicle));
    context.pop();
  }
}
// 328 ->
