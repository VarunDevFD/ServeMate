import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/features/product/presentation/bloc/dropdown_bloc/dropdown_bloc.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';

class DressTypeAndModel extends StatelessWidget {
  final ValueChanged<String> onTypeSelected;
  final ValueChanged<String> onModelSelected;
  const DressTypeAndModel(
      {super.key, required this.onModelSelected, required this.onTypeSelected});

  @override
  Widget build(BuildContext context) {
    final dressCondition = DropdownBloc();
    final dressModel = DropdownBloc();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ReusableDropdown(
              onDataSelected: onTypeSelected,
              bloc: dressCondition,
              items: const [
                'Formal',
                'Casual',
                'Traditional',
                'Bridal',
                "Groom's",
                'Bridesmaid',
                'Groomsmen',
                'Wedding Party'
              ],
              hint: "Select Dress Type",
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: ReusableDropdown(
              onDataSelected: onModelSelected,
              bloc: dressModel,
              items: const ['Suit', 'Tuxedo', 'Jacket'],
              hint: "Select Dress Model",
            ),
          ),
        ],
      ),
    );
  }
}
