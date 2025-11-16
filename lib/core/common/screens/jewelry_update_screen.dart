import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/common/bloc/switch_button_bloc/common_access_bloc/common_access_cubit.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/utils/dialog_utils.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart';
import 'package:serve_mate/core/utils/helper/image_helper.dart';
import 'package:serve_mate/core/widgets/dropdown_widget.dart';
import 'package:serve_mate/core/widgets/save_fab.dart';
import 'package:serve_mate/core/widgets/update_custom_text_field_widget.dart';
import 'package:serve_mate/core/widgets/update_image_section.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_bloc.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';

class JewelryUpdatePage extends StatelessWidget {
  final dynamic item;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController sdController;
  final TextEditingController descriptionController;
  final TextEditingController materialController;
  final TextEditingController typeController;
  final TextEditingController conditionController;
  final TextEditingController quantityController;
  final TextEditingController brandController;
  final TextEditingController phoneNumberController;

  JewelryUpdatePage({super.key, required this.item})
      : nameController = TextEditingController(text: item?.name),
        priceController = TextEditingController(text: item?.price?.toString()),
        sdController =
            TextEditingController(text: item?.securityDeposit?.toString()),
        descriptionController = TextEditingController(text: item?.description),
        typeController = TextEditingController(text: item?.type),
        materialController = TextEditingController(text: item?.material),
        quantityController = TextEditingController(text: item?.quantity),
        conditionController = TextEditingController(text: item?.condition),
        brandController = TextEditingController(text: item?.brand),
        phoneNumberController = TextEditingController(text: item?.phoneNumber);

  @override
  Widget build(BuildContext context) {
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
              if (state is LocationLoaded) location = state.location;
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
                DialogUtils.showStepDialog(
                  mainTitle: 'Update Facilities',
                  mainContent: 'Only taking new updates avoid previous data?',
                  context: context,
                  onConfirmed: () {
                    _saveChanges(
                      context,
                      isAvailable,
                      location,
                      flag1,
                      flag2,
                      oldImg,
                      newImg,
                    );
                  },
                  onSkip: () {
                    _saveChanges(
                      context,
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
      title: const Text('Jewelry Update'),
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
          SizedBox(height: 10.h),
          UpTextField(ctr: priceController, label: Names.price),
          SizedBox(height: 10.h),
          UpTextField(ctr: sdController, label: Names.securityDeposit),
          SizedBox(height: 10.h),
          UpTextField(ctr: descriptionController, label: Names.description),
          SizedBox(height: 10.h),
          UpTextField(ctr: quantityController, label: Names.quantity),
          SizedBox(height: 10.h),
          UpTextField(ctr: brandController, label: Names.brand),
          SizedBox(height: 10.h),
          UpTextField(ctr: phoneNumberController, label: Names.phoneNumber),
          SizedBox(height: 10.h),
          LocationTextField(item.location[0]),
          CustomDropdownBuilder.build(
            labelText: item.material ?? '${Names.material} *',
            items: DropdownItems.jewelryCategorys,
            controller: materialController,
          ),
          CustomDropdownBuilder.build(
            labelText: item.type ?? '${Names.type} *',
            items: DropdownItems.jewelryTypes,
            controller: typeController,
          ),
          CustomDropdownBuilder.build(
            labelText: item.condition ?? '${Names.condition}*',
            items: DropdownItems.condition,
            controller: conditionController,
          ),
          SizedBox(height: 10.h),
          const SwitchTileScreen(),
          SizedBox(height: 10.h),
          const ImageSection(),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }

  void _saveChanges(
    BuildContext context,
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

    if (flag1 && flag2) await Future.delayed(const Duration(seconds: 3));

    final updatedItem = item.copyWith(
      name: nameController.text,
      price: int.tryParse(priceController.text) ?? item.price,
      securityDeposit: int.tryParse(sdController.text) ?? item.securityDeposit,
      description: descriptionController.text,
      type: typeController.text,
      material: materialController.text,
      quantity: quantityController.text,
      condition: conditionController.text,
      brand: brandController.text,
      phoneNumber: phoneNumberController.text,
      images: images,
      location: location,
      available: isAvailable,
    );

    context
        .read<H2CategoryBloc>()
        .add(UpdateCategoryItemEvent(updatedItem, item.id, Names.jewelry));
    context.read<ImagePickerBloc>().add(ClearAllImages());

    context.pop();
  }
}
// 332 ->
