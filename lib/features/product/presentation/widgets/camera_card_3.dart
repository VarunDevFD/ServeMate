import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/card_constant.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';

class SectionThreeCameraCard extends StatelessWidget { 
  final TextEditingController phone;

  const SectionThreeCameraCard({
    super.key, 
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    
    final paddingEdges = AppPadding.paddingEdgesAll;
    return Card(
      shape: CardProperties.cardShape,
      child: Padding(
        padding: paddingEdges,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location & Contact',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10.h),
            // Location
             LocationTextField(),
            SizedBox(height: 10.h),
            // Phone value),
            TextFormField( 
              controller: phone,
              maxLength: 10,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                counterText: '',
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
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
