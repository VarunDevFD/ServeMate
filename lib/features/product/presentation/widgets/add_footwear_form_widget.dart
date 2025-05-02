import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/core/widgets/common_snackbar.dart';
import 'package:serve_mate/features/product/doamin/entities/footwear.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/tab_toggle_button.dart/bloc.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/submit_button_model.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import '../bloc/form_submission_bloc/form_submission_state.dart';

class FootwearPage extends StatelessWidget {
  FootwearPage({super.key});

  // Define FocusNode instances as static to persist across rebuilds
  static final _nameFocusNode = FocusNode();
  static final _brandFocusNode = FocusNode();
  static final _descriptionFocusNode = FocusNode();
  static final _priceFocusNode = FocusNode();
  static final _securityDepositFocusNode = FocusNode();
  static final _quantityFocusNode = FocusNode();
  static final _locationFocusNode = FocusNode();
  static final _phoneFocusNode = FocusNode();
  static final tAcFocusNode = FocusNode();

  // Controllers
  final TextEditingController name = TextEditingController();
  final TextEditingController brand = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController sdPrice = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController phone = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _resetFormState(BuildContext context) {
    _formKey.currentState?.reset();
    name.clear();
    quantity.clear();
    category.clear();
    price.clear();
    sdPrice.clear();
    description.clear();
    phone.clear();
    context.read<AvailableSwitchCubit>().reset();
    context.read<LocationBloc>().add(ResetLocationEvent());
    context.read<CheckBoxCubit>().reset();
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

  @override
  Widget build(BuildContext context) {
    final paddingEdges = AppPadding.paddingEdgesAll;
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
                    controller: name,
                    maxLength: 20,
                    keyboardType: TextInputType.text,
                    labelText: 'Enter Footwear Name *',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter the Footwear Name'
                        : null,
                    nextFocusNode: _brandFocusNode,
                    context: context,
                  ),
                ),
                buildSection(
                  title: 'Product Brand',
                  child: _buildTextFormField(
                    focusNode: _brandFocusNode,
                    controller: brand,
                    maxLength: 20,
                    keyboardType: TextInputType.text,
                    labelText: 'Enter Footwear Brand Name *',
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
                      category.text = value;
                    },
                  ),
                ),
                buildSection(
                  title: 'Size',
                  child: FilterChipScreen(
                    id: 'sizes',
                    categories: sizeOfFootwear,
                  ),
                ),
                buildSection(
                  title: 'Rental Price',
                  child: TextFormField(
                    maxLength: 6,
                    controller: price,
                    focusNode: _priceFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Price (per day)*',
                      counterText: '',
                      prefixIcon: Icon(Icons.attach_money),
                    ),
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
                    controller: sdPrice,
                    focusNode: _securityDepositFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Security Deposit *',
                      counterText: '',
                      prefixIcon: Icon(Icons.security_outlined),
                    ),
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
                    controller: quantity,
                    focusNode: _quantityFocusNode,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter the Count *',
                      counterText: '',
                      prefixIcon: Icon(Icons.add_outlined),
                    ),
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
                  child: const SwitchTileScreen(),
                ),
                buildSection(
                  title: 'Description',
                  child: TextFormField(
                    controller: description,
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
                    onFieldSubmitted: (value) =>
                        _moveFocus(context, _locationFocusNode),
                  ),
                ),
                buildSection(
                  title: 'Condition',
                  child: ReusableDropdown(
                    items: DropdownItems.condition,
                    labelText: 'Condition *',
                    onFieldSubmitted: (value) {
                      _moveFocus(context, _locationFocusNode);
                    },
                  ),
                ),
                buildSection(
                  title: 'Location',
                  child: LocationTextField(),
                ),
                buildSection(
                  title: 'Contact Number',
                  child: TextFormField(
                    controller: phone,
                    focusNode: _phoneFocusNode,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number *',
                      prefixIcon: Icon(Icons.phone_outlined),
                      counterText: '',
                    ),
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
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          const ImagePickerPage(),
                        ],
                      ),
                    ),
                  ),
                ),
                buildSection(
                  title: 'Terms and Conditions',
                  child: TermsAndConditionsScreen(
                    focusNode: tAcFocusNode,
                  ),
                ),
                ReusableButton(
                  label: 'Footwear Submit',
                  onPressed: () => submitFootwearData(context),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required FocusNode focusNode,
    required TextEditingController controller,
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
      controller: controller,
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

  Future<void> submitFootwearData(BuildContext context) async {
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
    final cubit = context.read<FilterChipCubit>();
    final selections = cubit.state.selections;
    final availableSwitchCubit = context.read<AvailableSwitchCubit>();
    final privacyPolicyCubit = context.read<CheckBoxCubit>();
    final color = context.read<DressFormBloc>();

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

      if (context.mounted) context.pop();

      if (uploadedState is ImagesUploaded) {
        final imageUrls = uploadedState.imageUrls;
        final locationState = locationBloc.state;
        final sizes = selections['sizes'] ?? [];

        if (locationState is LocationLoaded) {
          final location = locationState.location;
          final isAvailable = availableSwitchCubit.state;
          final isApproved = privacyPolicyCubit.state;
          final stateColor = color.state;
          final colorName = stateColor.colorName;
          log(colorName);

          final footwear = Footwear(
            name: name.text,
            size: sizes,
            color: colorName,
            brand: brand.text,
            price: int.tryParse(price.text) ?? 0,
            sdPrice: int.tryParse(sdPrice.text) ?? 0,
            condition: "condition",
            date: DateTime.now().toString(),
            location: location,
            images: imageUrls,
            available: isAvailable,
            description: description.text,
            category: category.text,
            phoneNumber: phone.text,
            privacyPolicy: isApproved,
            permission: 'pending',
          );
          if (context.mounted) {
            context.read<AddProductBloc>().add(FootwearEvent(footwear));
            _resetFormState(context);
          }
        } else {
          AppSnackBar.show(
            context,
            content: 'Please provide location information',
            backgroundColor: AppColors.red,
          );
        }
      }
    }
  }
}
