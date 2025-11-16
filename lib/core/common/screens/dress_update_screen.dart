import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/common/bloc/switch_button_bloc/common_access_bloc/common_access_cubit.dart';
import 'package:serve_mate/core/models/dress_model.dart';
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
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/widgets/gender_selector_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';

class DressUpdatePage extends StatelessWidget {
  final DressModel item;
  final TextEditingController name;
  final TextEditingController gender;
  final TextEditingController type;
  final TextEditingController size;
  final TextEditingController color;
  final TextEditingController material;
  final TextEditingController brand;
  final TextEditingController duration;
  final TextEditingController price;
  final TextEditingController sdPrice;
  final TextEditingController condition;
  final TextEditingController phoneNumber;
  final TextEditingController description;

  DressUpdatePage({super.key, required this.item})
      : name = TextEditingController(text: item.name),
        gender = TextEditingController(text: item.gender),
        type = TextEditingController(text: item.type),
        size = TextEditingController(text: item.size),
        color = TextEditingController(text: item.color),
        material = TextEditingController(text: item.material),
        brand = TextEditingController(text: item.brand),
        duration = TextEditingController(text: item.duration),
        price = TextEditingController(text: item.price.toString()),
        sdPrice = TextEditingController(text: item.sdPrice.toString()),
        condition = TextEditingController(text: item.condition),
        phoneNumber = TextEditingController(text: item.phoneNumber),
        description = TextEditingController(text: item.description);

  @override
  Widget build(BuildContext context) {
    String gender = item.gender;
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
          BlocListener<CommonBloc, CommonState>(listener: (context, state) {
            if (state is SuccessState) {
              gender = state.type;
            } else {
              gender = item.gender;
            }
          }),
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
          floatingActionButton: SaveFAB(
            onPressed: () {
              if (!emptyImg) {
                context.read<ImagePickerBloc>().add(SaveToCloudinary());
                DialogUtils.showStepDialog(
                  mainTitle: 'Update Data s',
                  mainContent: 'Only taking new updates avoid previous data?',
                  context: context,
                  onConfirmed: () {
                    if (oldImg.isEmpty) oldImg.addAll(item.images);

                    _saveChanges(context, gender, isAvailable, location, flag1,
                        flag2, oldImg, newImg);
                  },
                  onSkip: () {
                    if (oldImg.isEmpty) oldImg.addAll(item.images);

                    _saveChanges(context, gender, isAvailable, location, flag1,
                        flag2, oldImg, newImg);
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

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpTextField(ctr: name, label: Names.name),
          SizedBox(height: 16.h),
          UpTextField(ctr: type, label: Names.type),
          SizedBox(height: 16.h),
          UpTextField(ctr: size, label: Names.size),
          SizedBox(height: 16.h),
          UpTextField(ctr: color, label: Names.color),
          SizedBox(height: 16.h),
          UpTextField(ctr: material, label: Names.material),
          SizedBox(height: 16.h),
          UpTextField(ctr: brand, label: Names.brand),
          SizedBox(height: 16.h),
          UpTextField(ctr: duration, label: Names.duration),
          SizedBox(height: 16.h),
          UpTextField(ctr: price, label: Names.price),
          SizedBox(height: 16.h),
          UpTextField(ctr: sdPrice, label: Names.securityDeposit),
          SizedBox(height: 16.h),
          UpTextField(ctr: condition, label: Names.condition),
          SizedBox(height: 16.h),
          UpTextField(ctr: phoneNumber, label: Names.phoneNumber),
          SizedBox(height: 16.h),
          UpTextField(ctr: description, label: Names.description),
          SizedBox(height: 10.h),
          const GenderSelectionWidget(),
          SizedBox(height: 10.h),
          LocationTextField(item.location[0]),
          CustomDropdownBuilder.build(
            labelText: item.type ?? '${Names.dressType} *',
            items: DropdownItems.categoriesDress,
            controller: type,
          ),
          SizedBox(height: 10.h),
          SizedBox(height: 10.h),
          const ImageSection(),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }

  void _saveChanges(
    BuildContext context,
    String gender,
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
    final updatedItem = item.copyWith(
      name: name.text,
      gender: gender,
      type: type.text,
      size: size.text,
      color: color.text,
      material: material.text,
      brand: brand.text,
      duration: duration.text,
      price: int.tryParse(price.text) ?? item.price,
      sdPrice: int.tryParse(sdPrice.text) ?? item.sdPrice,
      condition: condition.text,
      date: item.date,
      phoneNumber: phoneNumber.text,
      description: description.text,
      images: item.images,
      location: location,
      available: isAvailable,
    );

    context
        .read<H2CategoryBloc>()
        .add(UpdateCategoryItemEvent(updatedItem, item.id, Names.dress));

    context.pop();
  }
}

// 420
