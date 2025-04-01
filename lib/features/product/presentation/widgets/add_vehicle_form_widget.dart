import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_state.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/text_field_with_color_picker.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormSubmissionBloc, FormMainState>(
      listener: (context, state) {
        if (state is VehicleSuccess) {
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

        if (state is VehicleSuccess && state.isAnimating) {
          log("Vehicle Animation true");
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

        const initialState = AppString.initialValue;
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
                          bloc.add(VehicleUpdateField('name', value)),
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
                        bloc.add(VehicleUpdateField('type', value));
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
                          bloc.add(VehicleUpdateField('brand', value)),
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
                        bloc.add(VehicleUpdateField('model', value));
                        _moveFocus(context, _capacityFocusNode);
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Vehicle Color',
                    child: TextFieldWithColorPicker(
                      onColorSelected: (controller) {
                        bloc.add(VehicleUpdateField('color', controller?.text));
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
                      onChanged: (value) => bloc.add(
                          VehicleUpdateField('capacity', int.tryParse(value))),
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
                        bloc.add(VehicleUpdateField('fuel', value));
                        _moveFocus(context, _transmissionFocusNode);
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Transmission Type',
                    child: ReusableDropdown(
                      labelText: 'Transmission Type *',
                      items: DropdownItems
                          .vehicleTransmissionItems, // Assuming this exists
                      onFieldSubmitted: (value) {
                        bloc.add(VehicleUpdateField('transmission', value));
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
                      onChanged: (value) =>
                          bloc.add(VehicleUpdateField('regNumber', value)),
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
                      onChanged: (value) => bloc.add(
                          VehicleUpdateField('price', int.tryParse(value))),
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
                      onChanged: (value) => bloc.add(
                          VehicleUpdateField('sdPrice', int.tryParse(value))),
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
                      id: 'facilities',
                      categories: facilitiesVehicle,
                      bloc: bloc,
                    ),
                  ),
                  buildSection(
                    title: 'Availability',
                    child: SwitchTileScreen(bloc: bloc),
                  ),
                  buildSection(
                    title: 'Location',
                    child: LocationTextField(
                      locationController:
                          TextEditingController(text: initialState),
                      onFieldSubmitted: (value) =>
                          bloc.add(VehicleUpdateField('location', value)),
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
                      onChanged: (value) =>
                          bloc.add(VehicleUpdateField('description', value)),
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
                              bloc: bloc,
                              validator: (images) => images.isEmpty
                                  ? 'Please upload at least one image'
                                  : null,
                            ),
                          ],
                        ),
                      ),
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
