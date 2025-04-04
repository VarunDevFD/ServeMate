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
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';

class VenuePage extends StatelessWidget {
  VenuePage({super.key});

  // Define FocusNode instances as static to persist across rebuilds
  static final _nameFocusNode = FocusNode();
  static final _locationFocusNode = FocusNode();
  static final _venueCapacityFocusNode = FocusNode();
  static final _durationFocusNode = FocusNode();
  static final _priceFocusNode = FocusNode();
  static final _sdFocusNode = FocusNode();
  static final _phoneFocusNode = FocusNode();
  static final _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormSubmissionBloc, FormMainState>(
      listener: (context, state) {
        if (state is VenueSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Venue form submitted successfully!')),
          );
          _clearFocus(context);
        } else if (state is Failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<FormSubmissionBloc>();

        if (state is VenueSuccess && state.isAnimating) {
          log("Venue Animation true");
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
                    title: 'Venue Name',
                    child: _buildTextFormField(
                      focusNode: _nameFocusNode,
                      initialValue: initialState,
                      maxLength: 20,
                      keyboardType: TextInputType.text,
                      labelText: 'Enter Venue Name *',
                      onChanged: (value) =>
                          bloc.add(VenueUpdateField('venue_name', value)),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the Venue Name'
                          : null,
                      nextFocusNode: _locationFocusNode,
                      context: context,
                    ),
                  ),
                  buildSection(
                    title: 'Location',
                    child: LocationTextField(
                      locationController:
                          TextEditingController(text: initialState),
                      onFieldSubmitted: (value) {
                        bloc.add(VenueUpdateField('location', value));
                        _moveFocus(context, _venueCapacityFocusNode);
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Venue Capacity',
                    child: TextFormField(
                      focusNode: _venueCapacityFocusNode,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter Venue Capacity *',
                        counterText: '',
                        prefixIcon: Icon(Icons.people_outline),
                      ),
                      onChanged: (value) => bloc.add(
                          VenueUpdateField('capacity', int.tryParse(value))),
                      onFieldSubmitted: (value) =>
                          _moveFocus(context, _durationFocusNode),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Venue Capacity';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Rental Duration',
                    child: ReusableDropdown(
                      labelText: 'Duration *',
                      items: DropdownItems.rentalDurationItems,
                      onFieldSubmitted: (value) {
                        bloc.add(
                            VenueUpdateField('duration', value.toString()));
                        _moveFocus(context, _priceFocusNode);
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Rental Price',
                    child: TextFormField(
                      focusNode: _priceFocusNode,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Price (per duration) *',
                        counterText: '',
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      onChanged: (value) => bloc
                          .add(VenueUpdateField('price', int.tryParse(value))),
                      onFieldSubmitted: (value) =>
                          _moveFocus(context, _sdFocusNode),
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
                  ),
                  buildSection(
                    title: 'Security Deposit',
                    child: TextFormField(
                      focusNode: _sdFocusNode,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Security Deposit *',
                        counterText: '',
                        prefixIcon: Icon(Icons.security_outlined),
                      ),
                      onChanged: (value) => bloc.add(
                          VenueUpdateField('sdPrice', int.tryParse(value))),
                      onFieldSubmitted: (value) =>
                          _moveFocus(context, _descriptionFocusNode),
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
                  ),
                  buildSection(
                    title: 'Venue Type',
                    child: ReusableDropdown(
                      labelText: 'Venue Type *',
                      items: DropdownItems.venueTypeItems,
                      onFieldSubmitted: (value) {
                        bloc.add(VenueUpdateField('venueType', value));
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Availability',
                    child: SwitchTileScreen(bloc: bloc),
                  ),
                  buildSection(
                    title: 'Facilities Available',
                    child: FilterChipScreen(
                      id: 'facilities',
                      categories: facilitiesVenue,
                      bloc: bloc,
                    ),
                  ),
                  buildSection(
                    title: 'Description',
                    child: TextFormField(
                      focusNode: _descriptionFocusNode,
                      initialValue: initialState,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      maxLines: 5,
                      maxLength: 100,
                      decoration: const InputDecoration(
                        labelText: 'Description *',
                        prefixIcon: Icon(Icons.description_outlined),
                        counterText: '',
                        alignLabelWithHint: true,
                      ),
                      onChanged: (value) =>
                          bloc.add(VenueUpdateField('description', value)),
                      onFieldSubmitted: (value) =>
                          _moveFocus(context, _phoneFocusNode),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a description'
                          : null,
                    ),
                  ),
                  buildSection(
                    title: 'Contact Number',
                    child: TextFormField(
                      focusNode: _phoneFocusNode,
                      initialValue: initialState,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number *',
                        prefixIcon: Icon(Icons.phone_outlined),
                        counterText: '',
                      ),
                      onChanged: (value) =>
                          bloc.add(VenueUpdateField('phoneNumber', value)),
                      onFieldSubmitted: (value) => _clearFocus(context),
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
                  ),
                  buildSection(
                    title: 'Venue Images',
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
                                  'Venue Images',
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
                  buildSection(
                    title: 'Terms and Conditions',
                    child: TermsAndConditionsScreen(
                      onChanged: (value) {
                        bloc.add(VenueUpdateField('privacyPolicy', value));
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
