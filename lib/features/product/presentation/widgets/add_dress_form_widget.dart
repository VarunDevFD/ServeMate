import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/widgets/common_snackbar.dart';
import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/tab_toggle_button.dart/bloc.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/dress_card_1.dart';
import 'package:serve_mate/features/product/presentation/widgets/dress_card_2.dart';
import 'package:serve_mate/features/product/presentation/widgets/dress_card_3.dart';
import 'package:serve_mate/features/product/presentation/widgets/dress_card_4.dart';
import 'package:serve_mate/features/product/presentation/widgets/dress_card_5.dart';
import 'package:serve_mate/features/product/presentation/widgets/submit_button_model.dart';
import '../bloc/form_submission_bloc/form_submission_state.dart';

class DressesPage extends StatelessWidget {
  DressesPage({super.key});
  final _formKey = GlobalKey<FormState>();
  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController sdPriceController = TextEditingController();
  final TextEditingController duratrionController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  static final tAcFocusNode = FocusNode();

  void _resetFormState(BuildContext context) {
    _formKey.currentState?.reset();
    nameController.clear();
    brandController.clear();
    typeController.clear();
    priceController.clear();
    sdPriceController.clear();
    duratrionController.clear();
    sizeController.clear();
    conditionController.clear();
    colorController.clear();
    materialController.clear();
    descriptionController.clear();
    phoneController.clear();
    context.read<AvailableSwitchCubit>().reset();
    context.read<LocationBloc>().add(ResetLocationEvent());
    context.read<CheckBoxCubit>().reset();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        if (state is AddSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AddFormError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Basic Information Card
                SectionOneDressCard(
                  name: nameController,
                  brand: brandController,
                  type: typeController,
                ),
                SizedBox(height: 16.h),
                // Dress Specifications
                SectionTwoDressCard(
                  size: sizeController,
                  condition: conditionController,
                  material: materialController,
                  description: descriptionController,
                ),
                SizedBox(height: 16.h),
                // Pricing and Availability Card
                SectionThreeDressCard(
                  price: priceController,
                  sdPrice: sdPriceController,
                  duration: duratrionController,
                ),

                SizedBox(height: 16.h),
                // Location and Contact Card
                SectionFourDressCard(phone: phoneController),
                const SizedBox(height: 16),
                // Image Upload Section
                const SectionFiveDressCard(),

                // Terms and Conditions
                TermsAndConditionsScreen(
                  focusNode: tAcFocusNode,
                ),
                ReusableButton(
                  label: 'Decoration Submit',
                  onPressed: () => submitDressData(context),
                ),
                SizedBox(height: 50.h)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitDressData(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      AppSnackBar.show(
        context,
        content: 'Please fill in all required fields',
        backgroundColor: AppColors.red,
      );
      return;
    }

    final imagePickerBloc = context.read<ImagePickerBloc>();
    final locationBloc = context.read<LocationBloc>();
    final availableSwitchCubit = context.read<AvailableSwitchCubit>();
    final privacyPolicyCubit = context.read<CheckBoxCubit>();
    final genderType = context.read<CommonBloc>();
    final color = context.read<DressFormBloc>();

    // Get current state
    final currentImageState = imagePickerBloc.state;
    if (currentImageState is ImageLoaded) {
      final images = currentImageState.images; // Correct property access
      if (images.isEmpty) {
        AppSnackBar.show(
          context,
          content: 'Please upload at least one image',
          backgroundColor: AppColors.red,
        );
        return;
      }

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
      imagePickerBloc.add(UploadImagesToCloudinary());

      final uploadedState = await imagePickerBloc.stream.firstWhere(
        (state) => state is ImagesUploaded || state is ImageError,
      );

      if (context.mounted) context.pop();

      if (uploadedState is ImagesUploaded) {
        final imageUrls = uploadedState.imageUrls;
        final locationState = locationBloc.state;
        final genderState = genderType.state;

        if (locationState is LocationLoaded) {
          final location = locationState.location;
          if (genderState is SuccessState) {
            final gender = genderState.type;
            final isAvailable = availableSwitchCubit.state;
            final isApproved = privacyPolicyCubit.state;
            final stateColor = color.state;
            final colorName = stateColor.colorName;
            log(colorName);

            final dress = Dress(
              name: nameController.text,
              gender: gender,
              type: typeController.text,
              size: sizeController.text,
              color: colorName,
              material: materialController.text,
              brand: brandController.text,
              duration: duratrionController.text,
              price: int.tryParse(priceController.text) ?? 0,
              sdPrice: int.tryParse(sdPriceController.text) ?? 0,
              condition: conditionController.text,
              date: DateTime.now().toString(),
              location: location,
              phoneNumber: phoneController.text,
              images: imageUrls,
              available: isAvailable,
              privacyPolicy: isApproved,
              description: descriptionController.text,
            );
            if (context.mounted) {
              context.read<AddProductBloc>().add(DressEvent(dress));
              _resetFormState(context);
            }
          } else {
            AppSnackBar.show(
              context,
              content: 'Please provide gender information',
              backgroundColor: AppColors.red,
            );
          }
        } else {
          AppSnackBar.show(
            context,
            content: 'Please provide location information',
            backgroundColor: AppColors.red,
          );
        }
      }
    }
  }
}
// 460
