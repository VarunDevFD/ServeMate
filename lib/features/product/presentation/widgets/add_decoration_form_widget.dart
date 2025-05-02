import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/widgets/common_snackbar.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_event.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/decoration_card_1.dart';
import 'package:serve_mate/features/product/presentation/widgets/decoration_card_2.dart';
import 'package:serve_mate/features/product/presentation/widgets/decoration_card_3.dart';
import 'package:serve_mate/features/product/presentation/widgets/decoration_card_4.dart';
import 'package:serve_mate/features/product/doamin/entities/decoration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/tab_toggle_button.dart/bloc.dart';

import 'submit_button_model.dart';

class DecorationPage extends StatelessWidget {
  DecorationPage({super.key});

  final _formKey = GlobalKey<FormState>();
  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController sdPriceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  static final tAcFocusNode =
      FocusNode(); // FocusNode for the Terms and Conditions checkbox

  void _resetFormState(BuildContext context) {
    _formKey.currentState?.reset();
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    sdPriceController.clear();
    durationController.clear();
    phoneController.clear();
    context.read<AvailableSwitchCubit>().reset();
    context.read<FilterChipCubit>().resetAll();
    context.read<LocationBloc>().add(ResetLocationEvent());
    context.read<CheckBoxCubit>().reset();
    context.read<ImagePickerBloc>().add(ClearAllImages());
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
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Basic Information Card
                SectionOneDecorationCard(
                  name: nameController,
                  description: descriptionController,
                ),
                SizedBox(height: 16.h),
                // Pricing and Availability Card
                SectionTwoDecorationCard(
                  price: priceController,
                  sdPrice: sdPriceController,
                  duration: durationController,
                ),
                SizedBox(height: 16.h),
                // Location and Contact Card
                SectionThreeDecorationCard(
                  phone: phoneController,
                ),
                SizedBox(height: 6.h),
                // Image Upload Section
                const SectionFourDecorationCard(),
                // Terms and Conditions
                TermsAndConditionsScreen(
                  focusNode: tAcFocusNode,
                ),
                ReusableButton(
                  label: 'Camera Submit',
                  onPressed: () {
                    submitDecorationData(context);
                  },
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitDecorationData(BuildContext context) async {
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
    final cubit = context.read<FilterChipCubit>();
    final selections = cubit.state.selections;
    final decorCategory = selections['decorCategory'] ?? [];
    final decorStyles = selections['decorStyles'] ?? [];

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

      // show loading dialog
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

      // Close loading dialog
      if (context.mounted) context.pop();

      if (uploadedState is ImagesUploaded) {
        // SUCCESS - Proceed with the rest of data save
        final imageUrls = uploadedState.imageUrls;
        final locationState = locationBloc.state;

        if (locationState is LocationLoaded) {
          final location = locationState.location;
          final isAvailable = availableSwitchCubit.state;
          final isApproved = privacyPolicyCubit.state;

          final decoration = DecorationEntity(
            name: nameController.text,
            decorCategory: decorCategory,
            decorStyles: decorStyles,
            description: descriptionController.text,
            price: int.tryParse(priceController.text) ?? 0,
            sdPrice: int.tryParse(sdPriceController.text) ?? 0,
            available: isAvailable,
            location: location,
            phoneNumber: phoneController.text,
            duration: durationController.text,
            images: imageUrls,
            privacyPolicy: isApproved,
          );

          if (context.mounted) {
            context.read<AddProductBloc>().add(DecorationEvent(decoration));

            _resetFormState(context);
          }
        } else {
          AppSnackBar.show(
            context,
            content: 'Please provide location information',
            backgroundColor: AppColors.red,
          );
        }
      } else if (uploadedState is ImageError) {
        // ERROR
        if (context.mounted) {
          AppSnackBar.show(
            context,
            content: 'Image Upload Error: ${uploadedState.message}',
            backgroundColor: AppColors.red,
          );
        }
      }
    } else {
      AppSnackBar.show(
        context,
        content: 'Please upload images first',
        backgroundColor: AppColors.red,
      );
    }
  }
}
// 316
