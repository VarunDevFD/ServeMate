import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/widgets/common_snackbar.dart';
import 'package:serve_mate/features/product/doamin/entities/jewelry.dart';
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
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import '../bloc/form_submission_bloc/form_submission_state.dart';

class JewelryPage extends StatelessWidget {
  JewelryPage({super.key});

  // Define FocusNode instances as static to persist across rebuilds
  static final _nameFocusNode = FocusNode();
  static final _brandFocusNode = FocusNode();
  static final _descriptionFocusNode = FocusNode();
  static final _priceFocusNode = FocusNode();
  static final _securityDepositFocusNode = FocusNode();
  static final _rentalDurationFocusNode = FocusNode();
  static final _locationFocusNode = FocusNode();
  static final _phoneFocusNode = FocusNode();
  static final tAcFocusNode = FocusNode();

  // Define form key
  final formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController cateogry = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController brand = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController stPrice = TextEditingController();
  final TextEditingController quandity = TextEditingController();
  final TextEditingController condition = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController phone = TextEditingController();

  _resetFormState(BuildContext context) {
    formKey.currentState?.reset();
    name.clear();
    cateogry.clear();
    type.clear();
    brand.clear();
    price.clear();
    stPrice.clear();
    quandity.clear();
    condition.clear();
    description.clear();
    phone.clear();
    context.read<AvailableSwitchCubit>().reset();
    context.read<LocationBloc>().add(ResetLocationEvent());
    context.read<CheckBoxCubit>().reset();
  }

  Future<void> submitJewelryData(BuildContext context) async {
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
    final availableSwitchCubit = context.read<AvailableSwitchCubit>();
    final privacyPolicyCubit = context.read<CheckBoxCubit>();

    final imageState = imagePickerBloc.state;
    if (imageState is ImageLoaded) {
      final images = imageState.images;
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

        if (locationState is LocationLoaded) {
          final location = locationState.location;
          final isAvailable = availableSwitchCubit.state;
          final isApproved = privacyPolicyCubit.state;

          final jewelry = Jewelry(
            name: name.text,
            material: cateogry.text,
            type: type.text,
            brand: brand.text,
            price: int.tryParse(price.text),
            securityDeposit: int.tryParse(stPrice.text),
            quantity: quandity.text,
            available: isAvailable,
            description: description.text,
            condition: condition.text,
            location: location,
            phoneNumber: phone.text,
            images: imageUrls,
            privacyPolicy: isApproved,
          );
          if (context.mounted) {
            context.read<AddProductBloc>().add(JewelryEvent(jewelry));
            _resetFormState(context);
          }
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
                  child: buildTextFormField(
                    focusNode: _nameFocusNode,
                    controller: name,
                    maxLength: 20,
                    keyboardType: TextInputType.text,
                    labelText: 'Enter Jewelry Name *',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter the Jewelry Name'
                        : null,
                    nextFocusNode: _brandFocusNode,
                    context: context,
                  ),
                ),
                buildSection(
                  title: 'Category',
                  child: ReusableDropdown(
                    labelText: 'Category*',
                    items: DropdownItems.jewelryCategorys,
                    onFieldSubmitted: (value) {
                      cateogry.text = value!;
                    },
                  ),
                ),
                buildSection(
                  title: 'Jewelry Type',
                  child: ReusableDropdown(
                    labelText: 'Type*',
                    items: DropdownItems.jewelryTypes,
                    onFieldSubmitted: (value) {
                      type.text = value!;
                      moveFocus(context, _brandFocusNode);
                    },
                  ),
                ),
                buildSection(
                  title: 'Brand Name',
                  child: buildTextFormField(
                    focusNode: _brandFocusNode,
                    controller: brand,
                    maxLength: 20,
                    keyboardType: TextInputType.text,
                    labelText: 'Enter Jewelry Brand Name *',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter the Jewelry Brand Name'
                        : null,
                    nextFocusNode: _priceFocusNode,
                    context: context,
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
                        moveFocus(context, _securityDepositFocusNode),
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
                    controller: stPrice,
                    maxLength: 6,
                    focusNode: _securityDepositFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Security Deposit *',
                      counterText: '',
                      prefixIcon: Icon(Icons.security_outlined),
                    ),
                    onFieldSubmitted: (value) =>
                        moveFocus(context, _rentalDurationFocusNode),
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
                    controller: quandity,
                    focusNode: _rentalDurationFocusNode,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter the Count *',
                      counterText: '',
                      prefixIcon: Icon(Icons.add_outlined),
                    ),
                    onFieldSubmitted: (value) =>
                        moveFocus(context, _descriptionFocusNode),
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
                        moveFocus(context, _locationFocusNode),
                  ),
                ),
                buildSection(
                  title: 'Condition',
                  child: ReusableDropdown(
                    items: DropdownItems.condition,
                    labelText: 'Condition *',
                    onFieldSubmitted: (value) {
                      if (value != null) {
                        condition.text = value;
                        moveFocus(context, _locationFocusNode);
                      }
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
                    onFieldSubmitted: (value) => clearFocus(context),
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
                  onPressed: () => submitJewelryData(context),
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

  Widget buildTextFormField({
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
          moveFocus(context, nextFocusNode);
        } else {
          clearFocus(context);
        }
      },
    );
  }

  void moveFocus(BuildContext context, FocusNode nextFocusNode) {
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  void clearFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}

// 410
