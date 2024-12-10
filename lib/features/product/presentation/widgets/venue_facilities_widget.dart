import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/venues_bloc/venues_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/venues_bloc/venues_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/venues_bloc/venues_state.dart';

class VenueFacilitiesWidget extends StatelessWidget {
  final ValueChanged<String> selectedFacilities;
  final List<String> facilities;

  const VenueFacilitiesWidget({
    Key? key,
    required this.facilities,
    required this.selectedFacilities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VenueFormBloc, VenueFormState>(
      builder: (context, state) {
        final bloc = context.read<VenueFormBloc>();
        int visibleCount = state.isFacilitiesExpanded ? facilities.length : 5;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Facilities displayed as FilterChips
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: facilities.take(visibleCount).map((facility) {
                return FilterChip(
                  label: Text(facility),
                  selected: state.selectedFacilities.contains(facility),
                  onSelected: (selected) {
                    log('Facility: $facility, Selected: $selected');
                    selectedFacilities(facility);
                    bloc.add(ToggleFacility(facility));
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 3.h),
            // "Show More/Show Less" toggle button
            if (facilities.length > 5)
              TextButton(
                onPressed: () {
                  bloc.add(ToggleFacilitiesListExpansion());
                },
                child: Text(
                  state.isFacilitiesExpanded ? "Show Less" : "Show More",
                  style: TextStyle(color: AppColors.orange1),
                ),
              ),
          ],
        );
      },
    );
  }
}
