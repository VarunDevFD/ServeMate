
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/card_constant.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/widgets/common_snackbar.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_cubit/image_cubit_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/tab_toggle_button.dart/bloc.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/gender_selector_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/text_field_with_color_picker.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';
import 'reusable_dropdown.dart';
import '../bloc/form_submission_bloc/form_submission_event.dart';
import '../bloc/form_submission_bloc/form_submission_state.dart';

class DressesPage extends StatelessWidget {
  DressesPage({super.key});

  static final tAcFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormSubmissionBloc, FormSubState>(
      listener: (context, state) async {
        if (state is FormSuccess) {
          await Future.delayed(const Duration(seconds: 5));
          AppSnackBar.show(
            context,
            content: 'Dress form submitted successfully!',
            backgroundColor: AppColors.green,
          );
        } else if (state is FormError) {
          AppSnackBar.show(
            context,
            content: state.message,
            backgroundColor: AppColors.green,
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<FormSubmissionBloc>();
        if (state is FormSuccess) {
          context.read<ImagePickerCubit>().clearImages();
          context.read<AvailableSwitchCubit>().toggleAvailable(false);
          context.read<FilterChipCubit>().resetAll();
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
          ); // Reset cubits here to prepare for form rebuild
        }

        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.r),
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
                          // Dress Name
                          TextFormField(
                            initialValue: Names.initialValue,
                            maxLength: 30,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Dress Name*',
                              counterText: '', // Hide the no. of Characters
                              prefixIcon: Icon(Icons.shopping_bag),
                            ),
                            onChanged: (value) => bloc
                                .add(FormUpdateEvent('dress', 'name', value)),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter dress name'
                                : null,
                          ),
                          SizedBox(height: 15.h),
                          // Brand
                          TextFormField(
                            initialValue: Names.initialValue,
                            maxLength: 30,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Dress Brand*',
                              counterText: '', // Hide the no. Pof Characters
                              prefixIcon: Icon(Icons.breakfast_dining_rounded),
                            ),
                            onChanged: (value) => bloc
                                .add(FormUpdateEvent('dress', 'brand', value)),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter dress name'
                                : null,
                          ),
                          SizedBox(height: 15.h),
                          // Type
                          ReusableDropdown(
                            labelText: 'Category*',
                            items: DropdownItems.categoriesDress,
                            onFieldSubmitted: (value) => bloc
                                .add(FormUpdateEvent('dress', 'type', value)),
                          ),
                          SizedBox(height: 6.h),
                          // Gender
                          GenderSelectionWidget(
                            onValue: (value) => bloc
                                .add(FormUpdateEvent('dress', 'gender', value)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Dress Specifications
                  Card(
                    elevation: 4,
                    shape: CardProperties.cardShape,
                    child: Padding(
                      padding: AppPadding.paddingEdgesAll,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.straighten, color: AppColors.orange1),
                              SizedBox(width: 6.h),
                              Text(
                                'Specifications',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          // Dress Size
                          ReusableDropdown(
                            labelText: 'Size*',
                            items: DropdownItems.sizes,
                            onFieldSubmitted: (value) => bloc
                                .add(FormUpdateEvent('dress', "size", value)),
                          ),
                          SizedBox(height: 6.h),
                          // Dress Condition
                          ReusableDropdown(
                            labelText: 'condition *',
                            items: DropdownItems.condition,
                            onFieldSubmitted: (value) => bloc.add(
                                FormUpdateEvent('dress', "condition", value)),
                          ),
                          SizedBox(height: 6.h),
                          // Dress Color
                          TextFieldWithColorPicker(
                            onColorSelected: (controller) => bloc.add(
                                FormUpdateEvent(
                                    'dress', 'color', controller?.text)),
                          ),
                          SizedBox(height: 6.h),
                          // Material
                          TextFormField(
                            initialValue: Names.initialValue,
                            maxLength: 30,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Material',
                              counterText: '',
                              prefixIcon: Icon(Icons.sell_outlined),
                            ),
                            onChanged: (value) => bloc.add(
                                FormUpdateEvent('dress', 'material', value)),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter dress material'
                                : null,
                          ),
                          SizedBox(height: 6.h),

                          // Description
                          TextFormField(
                            initialValue: Names.initialValue,
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
                                FormUpdateEvent('dress', 'description', value)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
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
                              const SizedBox(width: 8),
                              Text(
                                'Pricing & Availability',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Price
                          TextFormField(
                            initialValue: Names.initialValue,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Price*',
                              counterText: '',
                              prefixIcon: Icon(Icons.attach_money),
                            ),
                            onChanged: (value) => bloc.add(
                              FormUpdateEvent(
                                  'dress', 'price', int.tryParse(value)),
                            ),
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
                            initialValue: Names.initialValue,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Security Deposit *',
                              counterText: '',
                              prefixIcon: Icon(Icons.security_outlined),
                            ),
                            onChanged: (value) => bloc.add(
                              FormUpdateEvent(
                                  'dress', 'sdPrice', int.tryParse(value)),
                            ),
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
                            initialValue: Names.initialValue,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Minimum Rental Duration (days)*',
                            ),
                            onChanged: (value) => bloc.add(
                                FormUpdateEvent('dress', 'duration', value)),
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
                          // Availability
                          SwitchTileScreen(categoryName: 'dress', bloc: bloc),
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
                            locationController:
                                TextEditingController(text: Names.initialValue),
                            onFieldSubmitted: (value) => bloc.add(
                                FormUpdateEvent('dress', 'location', value)),
                          ),
                          SizedBox(height: 16.h),
                          // Phone
                          TextFormField(
                            initialValue: Names.initialValue,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) => bloc.add(
                                FormUpdateEvent('dress', 'phoneNumber', value)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Phone Number';
                              }
                              if (value.length != 10) {
                                return 'Please enter a valid 10-digit number';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              prefixIcon: Icon(Icons.phone_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                          ImagePickerPage(
                            categoryName: 'dress',
                            bloc: bloc,
                            validator: (images) => images.isEmpty
                                ? 'Please upload at least one image'
                                : null,
                          )
                        ],
                      ),
                    ),
                  ),

                  // Terms and Conditions
                  TermsAndConditionsScreen(
                    focusNode: tAcFocusNode,
                    onChanged: (value) {
                      context
                          .read<CheckBoxCubit>()
                          .checkeBoxAvailable(value!); // Update CheckBoxCubit
                      context.read<FormSubmissionBloc>().add(
                            FormUpdateEvent('dress', 'privacyPolicy', value),
                          );
                    },
                  ),

                  SizedBox(height: 50.h)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
// 460
