// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';

class DressTypeAndModel extends StatelessWidget {
  final TextEditingController catergoryController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final FocusNode catergoryFocusNode = FocusNode();
  final FocusNode modelFocusNode = FocusNode();
  final ValueChanged<bool> nextFocusNode;
  DressTypeAndModel({
    Key? key,
    required this.nextFocusNode,
    required TextEditingController catergoryController,
    required TextEditingController modelController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ReusableDropdown(
              labelText: "Select Dress Type *",
              items: DropdownItems.categoriesDress,
              onFieldSubmitted: (String? value) {
                catergoryController.clear();
                catergoryController.text = value ?? '';
                FocusScope.of(context).requestFocus(modelFocusNode);
              },
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: ReusableDropdown(
              labelText: "Select Dress Model *",
              items: DropdownItems.attireOptions,
              onFieldSubmitted: (String? value) {
                modelController.clear();
                modelController.text = value ?? '';
                nextFocusNode(true);
              },
            ),
          ),
        ],
      ),
    );
  }
}
