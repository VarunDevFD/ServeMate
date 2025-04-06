
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/card_constant.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/widgets/common_snackbar.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/tab_toggle_button.dart/bloc.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';
import '../bloc/image_cubit/image_cubit_cubit.dart';
import '../bloc/form_submission_bloc/form_submission_event.dart';
import '../bloc/form_submission_bloc/form_submission_state.dart';

class SoundDJPage extends StatelessWidget {
  SoundDJPage({super.key});

  // Define FocusNode instances as static to persist across rebuilds
  static final _nameFocusNode = FocusNode();
  static final _descriptionFocusNode = FocusNode();
  static final _priceFocusNode = FocusNode();
  static final _securityDepositFocusNode = FocusNode();
  static final _quantityFocusNode = FocusNode();
  static final _phoneFocusNode = FocusNode();
  static final tAcFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormSubmissionBloc, FormSubState>(
      listener: (context, state) async {
        if (state is FormSuccess) {
          await Future.delayed(const Duration(seconds: 5));
          AppSnackBar.show(
            context,
            content: 'Sound form submitted successfully!',
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
          context.read<CheckBoxCubit>().checkeBoxAvailable(false);
          context.read<AvailableSwitchCubit>().toggleAvailable(false);
          context.read<ImagePickerCubit>().clearImages();
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
              SizedBox(height: 10.h),
            ],
          );
        }

        const initialState = Names.initialValue;
        final paddingEdges = AppPadding.paddingEdgesAll;

        return Form(
          key: formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: paddingEdges,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSection(
                    title: 'Product Name',
                    child: _buildTextFormField(
                      focusNode: _nameFocusNode,
                      initialValue: initialState,
                      maxLength: 30,
                      keyboardType: TextInputType.text,
                      labelText: 'Enter Sound Name *',
                      onChanged: (value) =>
                          bloc.add(FormUpdateEvent('sound', 'name', value)),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the Sound Name'
                          : null,
                      nextFocusNode: _descriptionFocusNode,
                      context: context,
                    ),
                  ),
                  buildSection(
                    title: 'Category',
                    child: ReusableDropdown(
                      labelText: 'Category*',
                      items: DropdownItems.soundCategorys,
                      onFieldSubmitted: (value) {
                        bloc.add(FormUpdateEvent('sound', 'category', value));
                      },
                    ),
                  ),
                  FilterChipScreen(
                    keyName: 'sound',
                    id: 'sound equipment',
                    categories: DropdownItems.soundEquipmentTypes,
                    bloc: bloc,
                  ),
                  buildSection(
                    title: 'Description',
                    child: _buildTextFormField(
                      focusNode: _descriptionFocusNode,
                      initialValue: initialState,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      maxLines: 3,
                      maxLength: 100,
                      labelText: 'Description',
                      prefixIcon: const Icon(Icons.description_outlined),
                      alignLabelWithHint: true,
                      onChanged: (value) => bloc
                          .add(FormUpdateEvent('sound', 'description', value)),
                      nextFocusNode: _priceFocusNode,
                      context: context,
                    ),
                  ),
                  buildSection(
                    title: 'Rental Price',
                    child: _buildTextFormField(
                      initialValue: initialState,
                      focusNode: _priceFocusNode,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      labelText: 'Price (per day)*',
                      prefixIcon: const Icon(Icons.attach_money),
                      onChanged: (value) => bloc.add(FormUpdateEvent(
                          'sound', 'price', int.tryParse(value))),
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
                  buildSection(
                    title: 'Security Deposit',
                    child: _buildTextFormField(
                      focusNode: _securityDepositFocusNode,
                      initialValue: initialState,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      labelText: 'Security Deposit *',
                      prefixIcon: const Icon(Icons.security_outlined),
                      onChanged: (value) => bloc.add(FormUpdateEvent(
                          'sound', 'securityDeposit', int.tryParse(value))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Security Deposit';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid deposit';
                        }
                        return null;
                      },
                      nextFocusNode: _quantityFocusNode,
                      context: context,
                    ),
                  ),
                  buildSection(
                    title: 'Availability',
                    child: SwitchTileScreen(categoryName: 'sound', bloc: bloc),
                  ),
                  buildSection(
                    title: 'Location',
                    child: LocationTextField(
                      locationController:
                          TextEditingController(text: initialState),
                      onFieldSubmitted: (value) =>
                          bloc.add(FormUpdateEvent('sound', 'location', value)),
                    ),
                  ),
                  buildSection(
                    title: 'Contact Number',
                    child: _buildTextFormField(
                      focusNode: _phoneFocusNode,
                      initialValue: initialState,
                      textInputAction: TextInputAction.done,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      labelText: 'Phone Number *',
                      prefixIcon: const Icon(Icons.phone_outlined),
                      onChanged: (value) => bloc
                          .add(FormUpdateEvent('sound', 'phoneNumber', value)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Phone Number';
                        }
                        if (value.length != 10) {
                          return 'Please enter a valid 10-digit number';
                        }
                        return null;
                      },
                      context: context,
                    ),
                  ),
                  buildSection(
                    title: 'Product Images',
                    child: Card(
                      shape: CardProperties.cardShape,
                      child: Padding(
                        padding: paddingEdges,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.photo_library,
                                    color: AppColors.orange1),
                                SizedBox(width: 8.w),
                                Text(
                                  'Product Images',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            ImagePickerPage(
                              categoryName: 'sound',
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
                  ),
                  buildSection(
                    title: 'Terms and Conditions',
                    child: TermsAndConditionsScreen(
                      focusNode: tAcFocusNode,
                      onChanged: (value) {
                        context
                            .read<CheckBoxCubit>()
                            .checkeBoxAvailable(value!); // Update CheckBoxCubit
                        context.read<FormSubmissionBloc>().add(
                              FormUpdateEvent('sound', 'privacyPolicy', value),
                            );
                      },
 
                    ),
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
    TextInputAction? textInputAction,
    required BuildContext context,
  }) {
    return TextFormField(
      focusNode: focusNode,
      initialValue: initialValue,
      maxLength: maxLength,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: labelText,
        counterText: '',
        prefixIcon: prefixIcon,
        alignLabelWithHint: alignLabelWithHint,
      ),
      onChanged: onChanged,
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

  void _moveFocus(BuildContext context, FocusNode nextFocusNode) {
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  void _clearFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
