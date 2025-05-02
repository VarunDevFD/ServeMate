import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/widgets/common_snackbar.dart';
import 'package:serve_mate/features/product/doamin/entities/sound.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/tab_toggle_button.dart/bloc.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/submit_button_model.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';
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

  // Controllers
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController stPrice = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController phone = TextEditingController();

  final formKey = GlobalKey<FormState>();

  _resetFormState(BuildContext context) {
    formKey.currentState?.reset();
    name.clear();
    description.clear();
    price.clear();
    stPrice.clear();
    category.clear();
    phone.clear();
    context.read<AvailableSwitchCubit>().reset();
    context.read<LocationBloc>().add(ResetLocationEvent());
    context.read<CheckBoxCubit>().reset();
  }

  Future<void> submitSoundDJData(BuildContext context) async {
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
        (state) => state is ImagesUploaded,
      );
      if (context.mounted) context.pop();

      if (uploadedState is ImagesUploaded) {
        final imageUrls = uploadedState.imageUrls;
        final locationState = locationBloc.state;
        final types = selections['sound equipment'];

        if (locationState is LocationLoaded) {
          final location = locationState.location;
          final isAvailable = availableSwitchCubit.state;
          final isApproved = privacyPolicyCubit.state;
          final soundDJ = Sound(
            name: name.text,
            category: category.text,
            equipmentTypes: types,
            description: description.text,
            price: int.tryParse(price.text) ?? 0,
            securityDeposit: int.tryParse(stPrice.text) ?? 0,
            available: isAvailable,
            location: location,
            phoneNumber: phone.text,
            images: imageUrls,
            privacyPolicy: isApproved,
            permission: 'pending',
          );
          if (context.mounted) {
            context.read<AddProductBloc>().add(SoundEvent(soundDJ));
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
                  title: 'Product Name',
                  child: _buildTextFormField(
                    focusNode: _nameFocusNode,
                    controller: name,
                    maxLength: 30,
                    keyboardType: TextInputType.text,
                    labelText: 'Enter Sound Name *',
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
                      if (value != null) {
                        category.text = value;
                      }
                    },
                  ),
                ),
                buildSection(
                  title: "Types",
                  child: FilterChipScreen(
                    id: 'sound equipment',
                    categories: DropdownItems.soundEquipmentTypes,
                  ),
                ),
                buildSection(
                  title: 'Description',
                  child: _buildTextFormField(
                    focusNode: _descriptionFocusNode,
                    controller: description,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLines: 3,
                    maxLength: 100,
                    labelText: 'Description',
                    prefixIcon: const Icon(Icons.description_outlined),
                    alignLabelWithHint: true,
                    nextFocusNode: _priceFocusNode,
                    context: context,
                  ),
                ),
                buildSection(
                  title: 'Rental Price',
                  child: _buildTextFormField(
                    focusNode: _priceFocusNode,
                    controller: price,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    labelText: 'Price (per day)*',
                    prefixIcon: const Icon(Icons.attach_money),
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
                    controller: stPrice,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    labelText: 'Security Deposit *',
                    prefixIcon: const Icon(Icons.security_outlined),
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
                  child: const SwitchTileScreen(),
                ),
                buildSection(
                  title: 'Location',
                  child: LocationTextField(),
                ),
                buildSection(
                  title: 'Contact Number',
                  child: _buildTextFormField(
                    focusNode: _phoneFocusNode,
                    controller: phone,
                    textInputAction: TextInputAction.done,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    labelText: 'Phone Number *',
                    prefixIcon: const Icon(Icons.phone_outlined),
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
                  label: 'Sound DJ Submit',
                  onPressed: () => submitSoundDJData(context),
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
    TextInputAction? textInputAction,
    required BuildContext context,
  }) {
    return TextFormField(
      focusNode: focusNode,
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
