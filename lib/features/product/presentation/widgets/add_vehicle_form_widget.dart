import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/core/widgets/common_snackbar.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_cubit/image_cubit_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/tab_toggle_button.dart/bloc.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/text_field_with_color_picker.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
import '../bloc/form_submission_bloc/form_submission_event.dart';
import '../bloc/form_submission_bloc/form_submission_state.dart';

class VehiclesPage extends StatelessWidget {
  VehiclesPage({super.key});

  // Define FocusNode instances as static to persist across rebuilds
  static final _nameFocusNode = FocusNode();
  static final _typeFocusNode = FocusNode();
  static final _brandFocusNode = FocusNode();
  static final _modelFocusNode = FocusNode();
  static final _capacityFocusNode = FocusNode();
  static final _fuelFocusNode = FocusNode();
  static final _transmissionFocusNode = FocusNode();
  static final _regNumberFocusNode = FocusNode();
  static final _priceFocusNode = FocusNode();
  static final _securityDepositFocusNode = FocusNode();
  static final _facilitiesFocusNode = FocusNode();
  static final _descriptionFocusNode = FocusNode();
  static final tAcFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormSubmissionBloc, FormSubState>(
      listener: (context, state) async {
        if (state is FormSuccess) {
          await Future.delayed(const Duration(seconds: 5));
          AppSnackBar.show(
            context,
            content: 'Vehicle form submitted successfully!',
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
          context.read<FilterChipCubit>().resetAll();

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
                    title: 'Vehicle Name',
                    child: _buildTextFormField(
                      focusNode: _nameFocusNode,
                      initialValue: initialState,
                      maxLength: 20,
                      keyboardType: TextInputType.text,
                      labelText: 'Enter Vehicle Name *',
                      onChanged: (value) =>
                          bloc.add(FormUpdateEvent('vehicle', 'name', value)),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the Vehicle Name'
                          : null,
                      nextFocusNode: _typeFocusNode,
                      context: context,
                    ),
                  ),
                  buildSection(
                    title: 'Vehicle Type',
                    child: ReusableDropdown(
                      labelText: 'Vehicle Type *',
                      items: DropdownItems.vehicleTypeItems,
                      onFieldSubmitted: (value) {
                        bloc.add(FormUpdateEvent('vehicle', 'type', value));
                        _moveFocus(context, _brandFocusNode);
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Vehicle Brand',
                    child: _buildTextFormField(
                      focusNode: _brandFocusNode,
                      initialValue: initialState,
                      maxLength: 10,
                      keyboardType: TextInputType.text,
                      labelText: 'Enter Vehicle Brand Name *',
                      onChanged: (value) =>
                          bloc.add(FormUpdateEvent('vehicle', 'brand', value)),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the Vehicle Brand Name'
                          : null,
                      nextFocusNode: _modelFocusNode,
                      context: context,
                    ),
                  ),
                  buildSection(
                    title: 'Vehicle Model',
                    child: ReusableDropdown(
                      labelText: 'Model Year *',
                      items: DropdownItems.vehicleModelItems,
                      onFieldSubmitted: (value) {
                        bloc.add(FormUpdateEvent('vehicle', 'model', value));
                        _moveFocus(context, _capacityFocusNode);
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Vehicle Color',
                    child: TextFieldWithColorPicker(
                      onColorSelected: (controller) {
                        bloc.add(FormUpdateEvent(
                            'vehicle', 'color', controller?.text));
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Seating Capacity',
                    child: _buildTextFormField(
                      focusNode: _capacityFocusNode,
                      initialValue: initialState,
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      labelText: 'Enter Vehicle Seating Capacity *',
                      onChanged: (value) => bloc.add(FormUpdateEvent(
                          'vehicle', 'capacity', int.tryParse(value))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Vehicle Seating Capacity';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      nextFocusNode: _fuelFocusNode,
                      context: context,
                    ),
                  ),
                  buildSection(
                    title: 'Fuel Type',
                    child: ReusableDropdown(
                      labelText: 'Fuel Type *',
                      items: DropdownItems.vehicleFuelItems,
                      onFieldSubmitted: (value) {
                        bloc.add(FormUpdateEvent('vehicle', 'fuel', value));
                        _moveFocus(context, _transmissionFocusNode);
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Transmission Type',
                    child: ReusableDropdown(
                      labelText: 'Transmission Type *',
                      items: DropdownItems.vehicleTransmissionItems,
                      onFieldSubmitted: (value) {
                        bloc.add(
                            FormUpdateEvent('vehicle', 'transmission', value));
                        _moveFocus(context, _regNumberFocusNode);
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Registration Number',
                    child: _buildTextFormField(
                      focusNode: _regNumberFocusNode,
                      initialValue: initialState,
                      maxLength: 10,
                      keyboardType: TextInputType.text,
                      labelText: 'Enter Vehicle Registration Number *',
                      onChanged: (value) => bloc
                          .add(FormUpdateEvent('vehicle', 'regNumber', value)),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the Registration Number'
                          : null,
                      nextFocusNode: _priceFocusNode,
                      context: context,
                    ),
                  ),
                  buildSection(
                    title: 'Rental Price',
                    child: _buildTextFormField(
                      focusNode: _priceFocusNode,
                      initialValue: initialState,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      labelText: 'Price (per day) *',
                      prefixIcon: const Icon(Icons.attach_money),
                      onChanged: (value) => bloc.add(FormUpdateEvent(
                          'vehicle', 'price', int.tryParse(value))),
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
                          'vehicle', 'sdPrice', int.tryParse(value))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Security Deposit';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid deposit';
                        }
                        return null;
                      },
                      nextFocusNode: _facilitiesFocusNode,
                      context: context,
                    ),
                  ),
                  buildSection(
                    title: 'Facilities Available',
                    child: FilterChipScreen(
                      keyName: 'vehicle',
                      id: 'facilities',
                      categories: facilitiesVehicle,
                      bloc: bloc,
                    ),
                  ),
                  buildSection(
                    title: 'Availability',
                    child: SwitchTileScreen(
                        categoryName: initialState, bloc: bloc),
                  ),
                  buildSection(
                    title: 'Location',
                    child: LocationTextField(
                      locationController:
                          TextEditingController(text: initialState),
                      onFieldSubmitted: (value) => bloc
                          .add(FormUpdateEvent('vehicle', 'location', value)),
                    ),
                  ),
                  buildSection(
                    title: 'Description',
                    child: _buildTextFormField(
                      focusNode: _descriptionFocusNode,
                      initialValue: initialState,
                      maxLength: 100,
                      keyboardType: TextInputType.text,
                      labelText: 'Description',
                      prefixIcon: const Icon(Icons.description_outlined),
                      maxLines: 3,
                      alignLabelWithHint: true,
                      onChanged: (value) => bloc.add(
                          FormUpdateEvent('vehicle', 'description', value)),
                      context: context,
                    ),
                  ),
                  buildSection(
                    title: 'Product Images',
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.photo_library,
                                    color: Colors.orange),
                                SizedBox(width: 8.w),
                                Text(
                                  'Product Images',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            ImagePickerPage(
                              categoryName: initialState,
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
                    title: "Privacy Policy",
                    child: TermsAndConditionsScreen(
                      focusNode: tAcFocusNode,
                      onChanged: (value) {
                        context
                            .read<CheckBoxCubit>()
                            .checkeBoxAvailable(value!); // Update CheckBoxCubit
                        context.read<FormSubmissionBloc>().add(
                              FormUpdateEvent(
                                  'vehicle', 'privacyPolicy', value),
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
    required BuildContext context,
  }) {
    return TextFormField(
      focusNode: focusNode,
      initialValue: initialValue,
      maxLength: maxLength,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
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
// 450
