import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';

class FilterChipScreen extends StatelessWidget {
  final String id;
  final List<String> categories;
  final FormSubmissionBloc? bloc;

  FilterChipScreen({
    Key? key,
    this.bloc,
    required this.id,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterChipCubit, FilterChipState>(
      builder: (context, state) {
        final selectedItems = state.selections[id] ?? [];
        final isExpanded = state.isExpanded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: categories
                  .take(isExpanded ? categories.length : 5)
                  .map((category) {
                return FilterChip(
                  label: Text(category),
                  backgroundColor: AppColors.white2,
                  selected: selectedItems.contains(category),
                  selectedColor: AppColors.orange5,
                  onSelected: (bool selected) {
                    final newSelection = List<String>.from(selectedItems);
                    if (selected) {
                      newSelection.add(category);
                    } else {
                      newSelection.remove(category);
                    }
                    context
                        .read<FilterChipCubit>()
                        .updateSelection(id, newSelection);
                    bloc?.add(UpdateField(id, newSelection));
                    bloc?.add(DecorationUpdateField(id, newSelection));
                  },
                );
              }).toList(),
            ),
            if (categories.length > 5) ...[
              SizedBox(height: 3.h),
              if (!isExpanded)
                TextButton(
                  onPressed: () {
                    context.read<FilterChipCubit>().toggleExpanded(id);
                  },
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(color: AppColors.orange1),
                  ),
                  child: Text(
                    "Show More",
                    style: TextStyle(color: AppColors.orange1),
                  ),
                )
              else
                TextButton(
                  onPressed: () {
                    context.read<FilterChipCubit>().toggleExpanded(id);
                  },
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(color: AppColors.orange1),
                  ),
                  child: Text(
                    "Show Less",
                    style: TextStyle(color: AppColors.orange1),
                  ),
                ),
            ],
          ],
        );
      },
    );
  }
}
