import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/card_constant.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_cubit/image_cubit_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';

class DecorationPage extends StatelessWidget {
  DecorationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormSubmissionBloc, FormMainState>(
      listener: (context, state) {
        if (state is DecorationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form submitted successfully!')),
          );
        } else if (state is Failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<FormSubmissionBloc>();
        if (state is DecorationSuccess && state.isAnimating) {
          log("DecorationSuccess animation");
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                SizedBox(height: 16.h),
                Text(
                  'Processing...',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        } else if (state is DecorationSuccess && !state.isAnimating) {
          log("DecorationSuccess without animation");
          // Reset cubits here to prepare for form rebuild
          context.read<ImagePickerCubit>().clearImages();
          context.read<AvailableSwitchCubit>().toggleAvailable(false);
          context.read<FilterChipCubit>().resetAll();
        }
        if (state is DecorationSuccess) log('Success State State');
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(14.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic Information Card
                  Card(
                    elevation: 2,
                    shape: CardProperties.cardShape,
                    child: Padding(
                      padding: AppPadding.paddingEdgesAll,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: AppColors.orange1,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Basic Information',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          // Name
                          TextFormField(
                            initialValue: AppString.initialValue,
                            maxLength: 30,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Name*',
                              counterText:
                                  '', // Hide the maxLength count TextFormField
                              prefixIcon: Icon(Icons.inventory_2_outlined),
                            ),
                            onChanged: (value) =>
                                bloc.add(DecorationUpdateField('name', value)),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter the Decoration Name'
                                : null,
                          ),
                          SizedBox(height: 15.h),
                          // Category
                          Text(
                            'Category',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 6.h),
                          FilterChipScreen(
                            id: 'decorCategory',
                            categories: decorationCategory,
                            bloc: bloc,
                          ),
                          SizedBox(height: 10.h),
                          // DecorStyle
                          Text(
                            'Facilities',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 6.h),
                          FilterChipScreen(
                            id: 'decorStyles',
                            categories: decorThemes,
                          ),
                          SizedBox(height: 6.h),
                          // Description
                          TextFormField(
                            initialValue: AppString.initialValue,
                            maxLength: 100,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              prefixIcon: Icon(Icons.description_outlined),
                              alignLabelWithHint: true,
                            ),
                            onChanged: (value) => bloc.add(
                                DecorationUpdateField('description', value)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Pricing and Availability Card
                  Card(
                    elevation: 2,
                    shape: CardProperties.cardShape,
                    child: Padding(
                      padding: AppPadding.paddingEdgesAll,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.attach_money,
                                color: AppColors.orange1,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Pricing & Availability',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Price
                          TextFormField(
                            initialValue: AppString.initialValue,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Price*',
                              counterText: '',
                              prefixIcon: Icon(Icons.attach_money),
                            ),
                            onChanged: (value) => bloc.add(
                                DecorationUpdateField(
                                    'price', int.tryParse(value))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Rental Price';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          // Security Deposit
                          TextFormField(
                            initialValue: AppString.initialValue,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Security Deposit *',
                              counterText: '',
                              prefixIcon: Icon(Icons.security_outlined),
                            ),
                            onChanged: (value) => bloc.add(
                                DecorationUpdateField(
                                    'sdPrice', int.tryParse(value))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Security Deposit';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid deposit';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          // Minimum Rental Duration
                          TextFormField(
                            initialValue: AppString.initialValue,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Minimum Rental Duration (days)*',
                            ),
                            onChanged: (value) => bloc
                                .add(DecorationUpdateField('duration', value)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter minimum rental duration';
                              }
                              final number = int.tryParse(value);
                              if (number == null) {
                                return 'Please enter a valid number';
                              }
                              if (number <= 0) {
                                return 'Duration must be greater than 0';
                              }
                              if (number > 30) {
                                return 'Duration cannot exceed 30 days or One Month';
                              }

                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          SwitchTileScreen(bloc: bloc),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),
                  // Location and Contact Card
                  Card(
                    shape: CardProperties.cardShape,
                    child: Padding(
                      padding: AppPadding.paddingEdgesAll,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location & Contact',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 16.h),
                          // Location
                          LocationTextField(
                            locationController: TextEditingController(
                                text: AppString.initialValue),
                            onFieldSubmitted: (value) => bloc
                                .add(DecorationUpdateField('location', value)),
                          ),
                          SizedBox(height: 16.h),
                          // Phone Number
                          TextFormField(
                            initialValue: AppString.initialValue,
                            maxLength: 10,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              prefixIcon: Icon(Icons.phone_outlined),
                            ),
                            onChanged: (value) => bloc.add(
                                DecorationUpdateField('phoneNumber', value)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Phone Number';
                              }
                              if (value.length != 10) {
                                return 'Please enter a valid 10-digit number';
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  // Image Upload Section
                  Card(
                    shape: CardProperties.cardShape,
                    child: Padding(
                      padding: AppPadding.paddingEdgesAll,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.photo_library,
                                color: AppColors.orange1,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Product Images',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          ImagePickerPage(
                            bloc: bloc,
                            validator: (images) => images.isEmpty
                                ? 'Please upload at least one image'
                                : null,
                          ),
                          BlocBuilder<ImagePickerCubit, List<File>>(
                            builder: (context, images) {
                              return images.isNotEmpty
                                  ? TextButton(
                                      onPressed: () => context
                                          .read<ImagePickerCubit>()
                                          .clearImages(),
                                      child: const Text('Clear'),
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Terms and Conditions
                  TermsAndConditionsScreen(
                    onChanged: (value) {
                      context
                          .read<AvailableSwitchCubit>()
                          .checkeBoxAvailable(value!);
                      bloc.add(DecorationUpdateField('privacyPolicy', value));
                    },
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
// 316
