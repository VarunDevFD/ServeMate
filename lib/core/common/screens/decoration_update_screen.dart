import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/common/bloc/switch_button_bloc/common_access_bloc/common_access_cubit.dart';
import 'package:serve_mate/core/models/decoration_model.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/core/utils/dialog_utils.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart';
import 'package:serve_mate/core/utils/helper/image_helper.dart';
import 'package:serve_mate/core/widgets/save_fab.dart';
import 'package:serve_mate/core/widgets/update_custom_text_field_widget.dart';
import 'package:serve_mate/core/widgets/update_image_section.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_bloc.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';

class DecorationUpdatePage extends StatelessWidget {
  final DecorationModel item;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController sdPriceController;
  final TextEditingController durationController;
  final TextEditingController phoneNumberController;
  final TextEditingController descriptionController;

  DecorationUpdatePage({super.key, required this.item})
      : nameController = TextEditingController(text: item.name),
        priceController = TextEditingController(text: item.price.toString()),
        sdPriceController =
            TextEditingController(text: item.sdPrice.toString()),
        durationController = TextEditingController(text: item.duration),
        phoneNumberController = TextEditingController(text: item.phoneNumber),
        descriptionController = TextEditingController(text: item.description);

  @override
  Widget build(BuildContext context) {
    bool isFacilities1 = false;
    bool isFacilities2 = false;
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
                  mainTitle: 'Update Facilities Category Data',
                  mainContent: 'Only taking new updates avoid previous data?',
                  context: context,
                  onConfirmed: () {
                    if (oldImg.isEmpty) oldImg.addAll(item.images);
                    isFacilities1 = true;
                    DialogUtils.showStepDialog(
                      mainTitle: 'Update Facilities Category Data',
                      mainContent:
                          'Only taking new updates avoid previous data?',
                      context: context,
                      onConfirmed: () {
                        if (oldImg.isEmpty) oldImg.addAll(item.images);
                        isFacilities2 = true;
                        _saveChanges(
                            context,
                            isFacilities1,
                            isFacilities2,
                            isAvailable,
                            location,
                            flag1,
                            flag2,
                            oldImg,
                            newImg);
                      },
                      onSkip: () {
                        if (oldImg.isEmpty) oldImg.addAll(item.images);
                        isFacilities2 = false;
                        _saveChanges(
                            context,
                            isFacilities1,
                            isFacilities2,
                            isAvailable,
                            location,
                            flag1,
                            flag2,
                            oldImg,
                            newImg);
                      },
                    );
                    _saveChanges(context, isFacilities1, isFacilities2,
                        isAvailable, location, flag1, flag2, oldImg, newImg);
                  },
                  onSkip: () {
                    if (oldImg.isEmpty) oldImg.addAll(item.images);
                    isFacilities1 = false;
                    DialogUtils.showStepDialog(
                      mainTitle: 'Update Facilities Category Data',
                      mainContent:
                          'Only taking new updates avoid previous data?',
                      context: context,
                      onConfirmed: () {
                        if (oldImg.isEmpty) oldImg.addAll(item.images);
                        isFacilities2 = true;
                        _saveChanges(
                            context,
                            isFacilities1,
                            isFacilities2,
                            isAvailable,
                            location,
                            flag1,
                            flag2,
                            oldImg,
                            newImg);
                      },
                      onSkip: () {
                        if (oldImg.isEmpty) oldImg.addAll(item.images);
                        isFacilities2 = false;
                        _saveChanges(
                            context,
                            isFacilities1,
                            isFacilities2,
                            isAvailable,
                            location,
                            flag1,
                            flag2,
                            oldImg,
                            newImg);
                      },
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
      title: const Text('Decoration Update'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.read<ImagePickerBloc>().add(ClearAllImages());
          context.read<H2CategoryBloc>().add(H2LoadCategories());
          context.pop();
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpTextField(ctr: nameController, label: Names.name),
          SizedBox(height: 16.h),
          UpTextField(ctr: priceController, label: Names.price),
          SizedBox(height: 16.h),
          UpTextField(ctr: sdPriceController, label: Names.securityDeposit),
          SizedBox(height: 16.h),
          UpTextField(ctr: durationController, label: Names.duration),
          SizedBox(height: 16.h),
          UpTextField(ctr: phoneNumberController, label: Names.phoneNumber),
          SizedBox(height: 16.h),
          UpTextField(ctr: descriptionController, label: Names.description),
          SizedBox(height: 24.h),
          LocationTextField(item.location[0]),
          SizedBox(height: 24.h),
          _buildDecorationCategorySection(),
          SizedBox(height: 24.h),
          _buildDecorationStylesSection(),
          SizedBox(height: 24.h),
          const ImageSection(),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }

  Widget _buildDecorationCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Decoration Category',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data:\n${item.decorCategory.join('\n')}',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          'Choose the Data to Update',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        FilterChipScreen(
          id: 'decorCategory',
          categories: decorationCategory,
        ),
      ],
    );
  }

  Widget _buildDecorationStylesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Decoration Styles',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data:\n${item.decorStyles.join('\n')}',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        FilterChipScreen(
          id: 'decorStyles',
          categories: decorThemes,
        ),
      ],
    );
  }

  void _saveChanges(
    BuildContext context,
    bool isFacilities1,
    bool isFacilities2,
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
    final dynamic decorCategory;
    final dynamic decorStyles;

    if (isFacilities1) {
      decorCategory = List<String>.from(selections['decorCategory'] ?? []);
    } else {
      decorCategory = [
        ...List<String>.from(selections['decorCategory'] ?? []),
        ...item.decorCategory,
      ];
    }

    if (isFacilities2) {
      decorStyles = List<String>.from(selections['decorStyles'] ?? []);
    } else {
      decorStyles = [
        ...List<String>.from(selections['decorStyles'] ?? []),
        ...item.decorStyles,
      ];
    }
    final updatedItem = item.copyWith(
      name: nameController.text,
      price: int.tryParse(priceController.text) ?? item.price,
      sdPrice: int.tryParse(sdPriceController.text) ?? item.sdPrice,
      duration: durationController.text,
      phoneNumber: phoneNumberController.text,
      description: descriptionController.text,
      decorCategory: decorCategory,
      decorStyles: decorStyles!,
      images: images,
      location: location,
      available: isAvailable,
    );

    context
        .read<H2CategoryBloc>()
        .add(UpdateCategoryItemEvent(updatedItem, item.id, Names.decoration));

    context.pop();
  }
}

// 305 ->
