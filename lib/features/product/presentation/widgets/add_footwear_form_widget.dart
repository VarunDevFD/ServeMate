
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/widgets/common_snackbar.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/tab_toggle_button.dart/bloc.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import '../bloc/form_submission_bloc/form_submission_event.dart';
import '../bloc/form_submission_bloc/form_submission_state.dart';

class FootwearPage extends StatelessWidget {
  FootwearPage({super.key});

  // Define FocusNode instances as static to persist across rebuilds
  static final _nameFocusNode = FocusNode();
  static final _descriptionFocusNode = FocusNode();
  static final _priceFocusNode = FocusNode();
  static final _securityDepositFocusNode = FocusNode();
  static final _quantityFocusNode = FocusNode();
  static final _locationFocusNode = FocusNode();
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
            content: 'Footwear form submitted successfully!',
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
                      maxLength: 20,
                      keyboardType: TextInputType.text,
                      labelText: 'Enter Footwear Name *',
                      onChanged: (value) =>
                          bloc.add(FormUpdateEvent('footwear', 'name', value)),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the Footwear Name'
                          : null,
                      nextFocusNode: _priceFocusNode,
                      context: context,
                    ),
                  ),
                  buildSection(
                    title: 'Category',
                    child: ReusableDropdown(
                      labelText: 'Category*',
                      items: DropdownItems.footwearTypes,
                      onFieldSubmitted: (value) {
                        bloc.add(
                            FormUpdateEvent('footwear', 'category', value));
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Rental Price',
                    child: TextFormField(
                      maxLength: 6,
                      controller: priceController,
                      focusNode: _priceFocusNode,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Price (per day)*',
                        counterText: '',
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      onChanged: (value) => bloc.add(FormUpdateEvent(
                          'footwear', 'price', int.tryParse(value))),
                      onFieldSubmitted: (value) =>
                          _moveFocus(context, _securityDepositFocusNode),
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
                      maxLength: 6,
                      controller: sdController,
                      focusNode: _securityDepositFocusNode,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Security Deposit *',
                        counterText: '',
                        prefixIcon: Icon(Icons.security_outlined),
                      ),
                      onChanged: (value) => bloc.add(FormUpdateEvent(
                          'footwear', 'sdPrice', int.tryParse(value))),
                      onFieldSubmitted: (value) =>
                          _moveFocus(context, _quantityFocusNode),
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
                    title: 'Available Quantity',
                    child: TextFormField(
                      controller: quantityController,
                      focusNode: _quantityFocusNode,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter the Count *',
                        counterText: '',
                        prefixIcon: Icon(Icons.add_outlined),
                      ),
                      onChanged: (value) => bloc.add(FormUpdateEvent(
                          'footwear', 'quantity', int.tryParse(value))),
                      onFieldSubmitted: (value) =>
                          _moveFocus(context, _descriptionFocusNode),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the quantity';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Availability',
                    child:
                        SwitchTileScreen(categoryName: 'footwear', bloc: bloc),
                  ),
                  buildSection(
                    title: 'Description',
                    child: TextFormField(
                      controller: descriptionController,
                      focusNode: _descriptionFocusNode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        prefixIcon: Icon(Icons.description_outlined),
                        counterText: '',
                        alignLabelWithHint: true,
                      ),
                      onChanged: (value) => bloc.add(
                          FormUpdateEvent('footwear', 'description', value)),
                      onFieldSubmitted: (value) =>
                          _moveFocus(context, _locationFocusNode),
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
                              categoryName: 'footwear',
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
                    title: 'Condition',
                    child: ReusableDropdown(
                      items: DropdownItems.condition,
                      labelText: 'Condition *',
                      onFieldSubmitted: (value) {
                        bloc.add(
                            FormUpdateEvent('footwear', 'condition', value));
                        _moveFocus(context, _locationFocusNode);
                      },
                    ),
                  ),
                  buildSection(
                    title: 'Location',
                    child: LocationTextField(
                      locationController: locationController,
                      onFieldSubmitted: (value) => bloc
                          .add(FormUpdateEvent('footwear', 'location', value)),
                    ),
                  ),
                  buildSection(
                    title: 'Contact Number',
                    child: TextFormField(
                      controller: phoneController,
                      focusNode: _phoneFocusNode,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number *',
                        prefixIcon: Icon(Icons.phone_outlined),
                        counterText: '',
                      ),
                      onChanged: (value) => bloc.add(
                          FormUpdateEvent('footwear', 'phoneNumber', value)),
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
                    title: 'Terms and Conditions',
                    child: TermsAndConditionsScreen(
                      focusNode: tAcFocusNode,
                      onChanged: (value) {
                        context
                            .read<CheckBoxCubit>()
                            .checkeBoxAvailable(value!); // Update CheckBoxCubit
                        context.read<FormSubmissionBloc>().add(
                              FormUpdateEvent('footwear', 'privacyPolicy', value),
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
