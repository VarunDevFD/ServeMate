import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/card_constant.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_cubit/image_cubit_cubit.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/gender_selector_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/text_field_with_color_picker.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';
import 'reusable_dropdown.dart';

class FootwearPage extends StatelessWidget {
  const FootwearPage({super.key});

  // Define FocusNode instances as static to persist across rebuilds
  static final _nameFocusNode = FocusNode();
  static final _brandFocusNode = FocusNode();
  static final _descriptionFocusNode = FocusNode();
  static final _priceFocusNode = FocusNode();
  static final _securityDepositFocusNode = FocusNode();
  static final _rentalDurationFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormSubmissionBloc, FormMainState>(
      listener: (context, state) {
        if (state is FootWearSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form submitted successfully!')),
          );
          _clearFocus(context); // Clear focus on success
        } else if (state is Failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<FormSubmissionBloc>();
        if (state is FootWearSuccess && state.isAnimating) {
          log("FootWear Animation true");
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                SizedBox(height: 16.h),
                Text(
                  'Processing...',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }

        Widget buildSection({required String title, required Widget child}) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSideHeadText(title: title),
              child,
              SizedBox(height: 6.h),
            ],
          );
        }

        const initialState = AppString.initialValue;
        final paddingEdges = AppPadding.paddingEdgesAll;

        return Form(
          key: formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  buildSection(
                    title: 'Name',
                    child: _buildTextFormField(
                      focusNode: _nameFocusNode,
                      initialValue: initialState,
                      maxLength: 20,
                      keyboardType: TextInputType.text,
                      labelText: 'Enter Name*',
                      prefixIcon: const Icon(Icons.shopping_bag_outlined),
                      onChanged: (value) =>
                          bloc.add(FootWearUpdateField('name', value)),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the Name'
                          : null,
                      nextFocusNode: _brandFocusNode,
                      context: context,
                    ),
                  ),

                  // Brand
                  buildSection(
                    title: 'Brand',
                    child: _buildTextFormField(
                      focusNode: _brandFocusNode,
                      initialValue: initialState,
                      maxLength: 20,
                      keyboardType: TextInputType.text,
                      labelText: 'Enter the brand name*',
                      prefixIcon: const Icon(Icons.bubble_chart_rounded),
                      onChanged: (value) =>
                          bloc.add(FootWearUpdateField('brand', value)),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please Enter the Name'
                          : null,
                      nextFocusNode: _descriptionFocusNode,
                      context: context,
                    ),
                  ),

                  // Type
                  buildSection(
                    title: 'Category',
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0.h, bottom: 5.h),
                      child: ReusableDropdown(
                        labelText: 'Footwear Type',
                        items: DropdownItems.footwearTypes,
                        onFieldSubmitted: (value) {
                          bloc.add(FootWearUpdateField('category', value));
                        },
                      ),
                    ),
                  ),

                  // Size
                  buildSection(
                    title: 'Size',
                    child: ReusableDropdown(
                      labelText: 'Size',
                      items: DropdownItems.sizeFootwear,
                      onFieldSubmitted: (value) {
                        bloc.add(FootWearUpdateField('size', value));
                      },
                    ),
                  ),

                  // Gender Selection
                  GenderSelectionWidget(
                    onValue: (value) =>
                        bloc.add(FootWearUpdateField('gender', value)),
                  ),

                  // Color
                  buildSection(
                    title: 'Color',
                    child: TextFieldWithColorPicker(
                      onColorSelected: (controller) => bloc
                          .add(FootWearUpdateField('color', controller?.text)),
                    ),
                  ),

                  // Condition Dropdown
                  buildSection(
                    title: 'Condition',
                    child: ReusableDropdown(
                      items: DropdownItems.condition,
                      labelText: 'Condition *',
                      onFieldSubmitted: (value) {
                        bloc.add(FootWearUpdateField('condition', value));
                      },
                    ),
                  ),

                  // Description Field
                  buildSection(
                    title: 'Description',
                    child: _buildTextFormField(
                      focusNode: _descriptionFocusNode,
                      initialValue: initialState,
                      maxLength: 100,
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      labelText: 'Enter description *',
                      prefixIcon: const Icon(Icons.description_outlined),
                      alignLabelWithHint: true,
                      onChanged: (value) =>
                          bloc.add(FootWearUpdateField('description', value)),
                      nextFocusNode: _priceFocusNode,
                      context: context,
                    ),
                  ),

                  // Price Field
                  buildSection(
                    title: 'Rental Price',
                    child: _buildTextFormField(
                      focusNode: _priceFocusNode,
                      initialValue: initialState,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      labelText: 'Enter Rental Price*',
                      onChanged: (value) => bloc
                          .add(FootWearUpdateField('price', int.parse(value))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Rental Price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      nextFocusNode: _securityDepositFocusNode,
                      context: context,
                    ),
                  ),

                  // Security Deposit Field
                  buildSection(
                    title: 'Security Deposit',
                    child: _buildTextFormField(
                      focusNode: _securityDepositFocusNode,
                      initialValue: initialState,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      labelText: 'Enter Security Deposit *',
                      onChanged: (value) => bloc.add(
                          FootWearUpdateField('sdPrice', int.parse(value))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the security deposit';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid deposit';
                        }
                        return null;
                      },
                      nextFocusNode: _rentalDurationFocusNode,
                      context: context,
                    ),
                  ),

                  // Availability Switch
                  SwitchTileScreen(bloc: bloc),

                  // Rental Duration Field
                  buildSection(
                    title: 'Rental Duration',
                    child: _buildTextFormField(
                      focusNode: _rentalDurationFocusNode,
                      initialValue: initialState,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      labelText: 'Rental Duration Period*',
                      prefixIcon: const Icon(Icons.security_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Rental Duration Period';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid Period';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _clearFocus(context),
                      context: context,
                    ),
                  ),

                  // Image Upload Section
                  Card(
                    shape: CardProperties.cardShape,
                    child: Padding(
                      padding: paddingEdges,
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
                  SizedBox(height: 10.h),

                  // Pickup Location Field
                  buildSection(
                    title: 'Location',
                    child: LocationTextField(
                      locationController:
                          TextEditingController(text: initialState),
                      onFieldSubmitted: (value) =>
                          bloc.add(FootWearUpdateField('location', value)),
                    ),
                  ),

                  // Terms and Conditions
                  TermsAndConditionsScreen(
                    onChanged: (value) {
                      bloc.add(FootWearUpdateField('privacyPolicy', value));
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

  // Helper method to build TextFormField with focus management
  Widget _buildTextFormField({
    required FocusNode focusNode,
    required String initialValue,
    required int maxLength,
    required TextInputType keyboardType,
    required String labelText,
    Widget? prefixIcon,
    int? maxLines,
    bool alignLabelWithHint = false,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    FocusNode? nextFocusNode,
    void Function(String)? onFieldSubmitted,
    required BuildContext context,
  }) {
    return TextFormField(
      focusNode: focusNode,
      initialValue: initialValue,
      maxLength: maxLength,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        counterText: '',
        prefixIcon: prefixIcon,
        alignLabelWithHint: alignLabelWithHint,
      ),
      onChanged: (value) {
        onChanged?.call(value);
        // Ensure focus is retained when editing
        if (!focusNode.hasFocus) {
          focusNode.requestFocus();
        }
      },
      validator: validator,
      onFieldSubmitted: (value) {
        onFieldSubmitted?.call(value);
        if (nextFocusNode != null) {
          _moveFocus(context, nextFocusNode);
        } else {
          _clearFocus(context);
        }
      },
    );
  }

  // Helper method to move focus to the next field
  void _moveFocus(BuildContext context, FocusNode nextFocusNode) {
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  // Helper method to clear focus (hide keyboard)
  void _clearFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
