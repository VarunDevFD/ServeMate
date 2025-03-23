import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_cubit/image_cubit_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';

class Cameras extends StatelessWidget {
  Cameras({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormSubmissionBloc, FormMainState>(
        builder: (context, state) {
      final bloc = context.read<FormSubmissionBloc>();
      return _buildForm(context, bloc);
    });
  }

  Widget _buildForm(BuildContext context, FormSubmissionBloc bloc) {
    final FocusNode nameFocusNode = FocusNode();
    final FocusNode brandFocusNode = FocusNode();
    final FocusNode modelFocusNode = FocusNode();
    final FocusNode categoryFocusNode = FocusNode();
    final FocusNode descriptionFocusNode = FocusNode();
    final FocusNode priceFocusNode = FocusNode();
    final FocusNode sdFocusNode = FocusNode();
    final FocusNode locationFocusNode = FocusNode();
    final FocusNode phoneFocusNode = FocusNode();
    final FocusNode conditionFocusNode = FocusNode();
    final FocusNode minDurationFocusNode = FocusNode();
    final FocusNode lateFeeFocusNode = FocusNode();

    final focusNode = FocusScope.of(context);

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        // controller: scrollController,
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name, Brand, Model, Category and Description
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.r)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: AppColors.orange1),
                          SizedBox(width: 8.w),
                          Text(
                            'Basic Information',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      // Name
                      TextFormField(
                        maxLength: 30,
                        focusNode: nameFocusNode,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Name*',
                          counterText:
                              '', // Hide the maxLength count TextFormField
                          prefixIcon: Icon(Icons.inventory_2_outlined),
                        ),
                        onFieldSubmitted: (value) {
                          bloc.add(UpdateField('name', value));
                          focusNode.requestFocus(modelFocusNode);
                        },
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter the Name'
                            : null,
                      ),
                      SizedBox(height: 10.h),
                      // Model
                      TextFormField(
                        maxLength: 30,
                        focusNode: modelFocusNode,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Model*',
                          counterText: '',
                          prefixIcon: Icon(Icons.category),
                        ),
                        onFieldSubmitted: (value) {
                          bloc.add(UpdateField('model', value));
                          focusNode.requestFocus(brandFocusNode);
                        },
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter the Decoration Name'
                            : null,
                      ),
                      SizedBox(height: 10.h),
                      // Brand
                      ReusableDropdown(
                        labelText: 'Equipment Brand *',
                        focusNode: brandFocusNode,
                        items: DropdownItems.brandsCamera,
                        onFieldSubmitted: (value) {
                          bloc.add(UpdateField('brand', value));
                          focusNode.requestFocus(categoryFocusNode);
                        },
                      ),
                      SizedBox(height: 10.h),
                      // Category
                      ReusableDropdown(
                        labelText: 'Category*',
                        focusNode: categoryFocusNode,
                        items: DropdownItems.categoriesCamera,
                        onFieldSubmitted: (value) {
                          bloc.add(UpdateField('category', value));
                          focusNode.requestFocus(descriptionFocusNode);
                        },
                      ),
                      SizedBox(height: 10.h),
                      // Description
                      TextFormField(
                        controller: descriptionController,
                        focusNode: descriptionFocusNode,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          prefixIcon: Icon(Icons.description_outlined),
                          alignLabelWithHint: true,
                        ),
                        onFieldSubmitted: (value) {
                          bloc.add(UpdateField('description', value));
                          focusNode.requestFocus(priceFocusNode);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Pricing and Availability Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.r)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    children: [
                      // Title
                      Row(
                        children: [
                          Icon(Icons.attach_money, color: AppColors.orange1),
                          SizedBox(width: 8.w),
                          Text(
                            'Pricing & Availability',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      // Price
                      TextFormField(
                        maxLength: 6,
                        focusNode: priceFocusNode,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Price*',
                          counterText: '',
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        onFieldSubmitted: (value) {
                          bloc.add(UpdateField('price', int.parse(value)));
                          focusNode.requestFocus(sdFocusNode);
                        },
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
                      SizedBox(height: 10.h),
                      // Security Deposit
                      TextFormField(
                        maxLength: 6,
                        focusNode: sdFocusNode,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Security Deposit *',
                          counterText: '',
                          prefixIcon: Icon(Icons.security_outlined),
                        ),
                        onFieldSubmitted: (value) {
                          bloc.add(UpdateField('sdPrice', int.parse(value)));
                        },
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
                      SizedBox(height: 10.h),
                      SwitchTileScreen(bloc: bloc),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Location and Contact Card
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location & Contact',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      // Location
                      LocationTextField(
                        locationFocusNode: locationFocusNode,
                        locationController: locationController,
                        onFieldSubmitted: (List<String>? value) {
                          bloc.add(UpdateField('location', value));
                          focusNode.requestFocus(phoneFocusNode);
                        },
                      ),
                      SizedBox(height: 10.h),
                      // Phone value),
                      TextFormField(
                        maxLength: 10,
                        controller: phoneController,
                        focusNode: phoneFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        onFieldSubmitted: (value) {
                          bloc.add(UpdateField('phoneNumber', value));
                          focusNode.requestFocus(conditionFocusNode);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          counterText: '',
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
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
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
              // Features & Specifications
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Features & Specifications',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      // Condition
                      ReusableDropdown(
                        items: DropdownItems.condition,
                        labelText: 'Condition *',
                        focusNode: conditionFocusNode,
                        onFieldSubmitted: (String? value) {
                          conditionController.clear();
                          conditionController.text = value ?? '';
                          bloc.add(UpdateField('condition', value));
                        },
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Storage Options',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 6.h),
                      FilterChipScreen(
                        id: 'storage',
                        categories: DropdownItems.storageOptionsCamera,
                        bloc: bloc,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Connectivity Options',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 6.h),
                      FilterChipScreen(
                        id: 'connectivity',
                        categories: DropdownItems.connectivityOptionsCamera,
                        bloc: bloc,
                      ),
                      SizedBox(height: 16.h),
                      // Minimum Rental Duration
                      TextFormField(
                        focusNode: minDurationFocusNode,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Minimum Rental Duration (days)*',
                        ),
                        onFieldSubmitted: (value) {
                          bloc.add(UpdateField('duration', value));
                          focusNode.requestFocus(lateFeeFocusNode);
                        },
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
                      SizedBox(height: 6.h),
                      // Late Fee Policy
                      TextFormField(
                        focusNode: lateFeeFocusNode,
                        decoration: const InputDecoration(
                          labelText: 'Late Fee Policy*',
                        ),
                        onFieldSubmitted: (value) {
                          lateFeeFocusNode.unfocus();
                          bloc.add(UpdateField('latePolicy', value));
                          log(value);
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Accessories are required' : null,
                      ),
                      SizedBox(height: 6.h),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 6.h),

              // Image Upload Section
              Card(
                child: Padding(
                  padding: EdgeInsets.all(20.r),
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
                      ImagePickerPage(bloc: bloc),
                      BlocBuilder<ImagePickerCubit, List<File>>(
                        builder: (context, images) {
                          return images.isNotEmpty
                              ? TextButton(
                                  onPressed: () {
                                    context
                                        .read<ImagePickerCubit>()
                                        .clearImages();
                                  },
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
                onChanged: (bool? value) {
                  context
                      .read<AvailableSwitchCubit>()
                      .checkeBoxAvailable(value!);
                  bloc.add(UpdateField('privacyPolicy', value));
                },
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
