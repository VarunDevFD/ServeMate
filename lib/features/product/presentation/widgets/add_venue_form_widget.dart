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
import 'package:serve_mate/features/product/doamin/entities/venue.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/tab_toggle_button.dart/bloc.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/submit_button_model.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import '../bloc/form_submission_bloc/form_submission_state.dart';

class VenuePage extends StatelessWidget {
  VenuePage({super.key});

  final formKey = GlobalKey<FormState>();
  // Define FocusNode instances as static to persist across rebuilds
  static final _nameFocusNode = FocusNode();
  static final _locationFocusNode = FocusNode();
  static final _venueCapacityFocusNode = FocusNode();
  static final _durationFocusNode = FocusNode();
  static final _priceFocusNode = FocusNode();
  static final _sdFocusNode = FocusNode();
  static final _phoneFocusNode = FocusNode();
  static final _descriptionFocusNode = FocusNode();
  static final tAcFocusNode = FocusNode();

  // Controller's
  final TextEditingController name = TextEditingController();
  final TextEditingController capacity = TextEditingController();
  final TextEditingController duration = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController sdPrice = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController description = TextEditingController();

  void _resetFormState(BuildContext context) {
    formKey.currentState?.reset();
    name.clear();
    capacity.clear();
    duration.clear();
    price.clear();
    sdPrice.clear();
    type.clear();
    phone.clear();
    description.clear();
    context.read<AvailableSwitchCubit>().reset();
    context.read<FilterChipCubit>().resetAll();
    context.read<LocationBloc>().add(ResetLocationEvent());
    context.read<CheckBoxCubit>().reset();
    context.read<ImagePickerBloc>().add(ClearAllImages());
  }

  Future<void> submitVenueData(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
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
        final facilities = selections['facilities'] ?? [];

        if (locationState is LocationLoaded) {
          final location = locationState.location;
          final isAvailable = availableSwitchCubit.state;
          final isApproved = privacyPolicyCubit.state;

          final venue = Venue(
            name: name.text,
            location: location,
            capacity: int.tryParse(capacity.text) ?? 0,
            duration: duration.text,
            venueType: type.text,
            price: int.tryParse(price.text) ?? 0,
            sdPrice: int.tryParse(sdPrice.text) ?? 0,
            images: imageUrls,
            available: isAvailable,
            facilities: facilities,
            description: description.text,
            phoneNumber: phone.text,
            privacyPolicy: isApproved,
          );

          context
              .read<AddProductBloc>()
              .add(VenueEvent(venue)); // Add to firebase
          _resetFormState(context); // reset the controllers
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

  @override
  Widget build(BuildContext context) {
    final paddingEdges = AppPadding.paddingEdgesAll;
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) async {
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
                    context: context,
                    focusNode: _nameFocusNode,
                    controller: name,
                    maxLength: 20,
                    keyboardType: TextInputType.text,
                    labelText: 'Enter Venue Name *',
                    onFieldSubmitted: (value) =>
                        _moveFocus(context, _locationFocusNode),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter the Venue Name'
                        : null,
                  ),
                ),
                buildSection(
                  title: 'Venue Capacity',
                  child: _buildTextFormField(
                    context: context,
                    focusNode: _venueCapacityFocusNode,
                    controller: capacity,
                    maxLength: 6,
                    labelText: 'Enter Venue Capacity *',
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.people_outline),
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
                  title: 'Rental Price',
                  child: _buildTextFormField(
                    context: context,
                    focusNode: _priceFocusNode,
                    controller: price,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    labelText: 'Price (per duration) *',
                    prefixIcon: const Icon(Icons.attach_money),
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
                  child: _buildTextFormField(
                    context: context,
                    focusNode: _sdFocusNode,
                    controller: sdPrice,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    labelText: 'Security Deposit *',
                    prefixIcon: const Icon(Icons.security_outlined),
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
                  title: 'Rental Duration & Venue Type',
                  child: Column(
                    children: [
                      SizedBox(height: 5.h),
                      ReusableDropdown(
                        labelText: 'Duration *',
                        items: DropdownItems.rentalDurationItems,
                        onFieldSubmitted: (value) {
                          duration.text = value;
                          _moveFocus(context, _priceFocusNode);
                        },
                      ),
                      SizedBox(height: 5.h),
                      ReusableDropdown(
                        labelText: 'Venue Type *',
                        items: DropdownItems.venueTypeItems,
                        onFieldSubmitted: (value) {
                          type.text = value;
                        },
                      ),
                    ],
                  ),
                ),
                buildSection(
                  title: 'Location',
                  child: LocationTextField(),
                ),
                buildSection(
                  title: 'Availability',
                  child: const SwitchTileScreen(),
                ),
                buildSection(
                  title: 'Facilities Available',
                  child: FilterChipScreen(
                    id: 'facilities',
                    categories: facilitiesVenue,
                  ),
                ),
                buildSection(
                  title: 'Description',
                  child: TextFormField(
                    focusNode: _descriptionFocusNode,
                    controller: description,
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
                    onFieldSubmitted: (value) =>
                        _moveFocus(context, _phoneFocusNode),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter a description'
                        : null,
                  ),
                ),
                buildSection(
                  title: 'Contact Number',
                  child: _buildTextFormField(
                    context: context,
                    focusNode: _phoneFocusNode,
                    controller: phone,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    labelText: 'Phone Number *',
                    prefixIcon: const Icon(Icons.phone_outlined),
                    onFieldSubmitted: (value) =>
                        _moveFocus(context, tAcFocusNode),
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
                Card(
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
                            Icon(Icons.photo_library, color: AppColors.orange),
                            SizedBox(width: 8.w),
                            Text(
                              'Venue Images',
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
                buildSection(
                  title: 'Terms and Conditions',
                  child: FormField(
                    validator: (value) {
                      final isChecked = context.read<CheckBoxCubit>().state;
                      if (isChecked == false) {
                        return 'You must accept the Terms and Conditions';
                      }
                      return null;
                    },
                    builder: (state) {
                      return TermsAndConditionsScreen(
                        focusNode: tAcFocusNode,
                      );
                    },
                  ),
                ),
                ReusableButton(
                  label: 'Venue Submit',
                  onPressed: () => submitVenueData(context),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
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
    TextInputAction? textInputAction,
  }) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      maxLength: maxLength,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        // labelText: labelText,
        hintText: labelText,
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
