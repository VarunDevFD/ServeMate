import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_state.dart';

class FilterChipScreen extends StatelessWidget {
  final Function(List<String>) onSelectionChanged;
  final List<String> categories;
  final String id;
  const FilterChipScreen({
    Key? key,
    required this.categories,
    required this.onSelectionChanged,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormSubBloc, FormSubState>(
      builder: (context, state) {
        final bloc = context.read<FormSubBloc>();
        final isExpanded = state.isFilterChipExpanded[id] ?? false;
        final int visibleCount = isExpanded ? categories.length : 5;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: categories.take(visibleCount).map((category) {
                return FilterChip(
                  label: Text(category),
                  // focusNode: focusNode,
                  backgroundColor: AppColors.white2,
                  selected: state.selectedFilters.contains(category),
                  selectedColor: AppColors.orange5,
                  onSelected: (bool selected) {
                    // bloc.add(ToggleFilterEvent(category));
                    final updatedSelection =
                        List<String>.from(state.selectedFilters);
                    if (selected) {
                      updatedSelection.add(category);
                    } else {
                      updatedSelection.remove(category);
                    }
                    onSelectionChanged(updatedSelection);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 3.h),
            if (categories.length > 5)
              TextButton(
                // focusNode: focusNode,
                onPressed: () {
                  bloc.add(FilterExpantionEvent(id));
                },
                child: Text(
                  isExpanded ? "Show Less" : "Show More",
                  style: TextStyle(color: AppColors.orange1),
                ),
              ),
          ],
        );
      },
    );
  }
}
