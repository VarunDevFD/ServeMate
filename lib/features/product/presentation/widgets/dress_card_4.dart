// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:serve_mate/core/utils/card_constant.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';

class SectionFourDressCard extends StatelessWidget {
  final TextEditingController phone;
  const SectionFourDressCard({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: CardProperties.cardShape,
      child: Padding(
        padding: AppPadding.paddingEdgesAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location & Contact',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16.h),
            // Location
            LocationTextField(),
            SizedBox(height: 16.h),
            // Phone
            TextFormField( 
              controller: phone,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
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
          ],
        ),
      ),
    );
  }
}
