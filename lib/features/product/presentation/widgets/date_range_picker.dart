import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/utils/theme/input_decoration.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_state.dart';

class DateRangePickerField extends StatelessWidget {
  const DateRangePickerField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DressFormBloc, DressFormState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            final DateTimeRange? pickedDateRange = await showDateRangePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (pickedDateRange != null) {
              context.read<DressFormBloc>().add(
                    DateRangeSelected(pickedDateRange),
                  );
            }
          },
          child: TextFormField(
            enabled: false,
            controller: TextEditingController(
              text: state.selectedDateRange != null
                  ? '${state.selectedDateRange!.start} - ${state.selectedDateRange!.end}'
                  : 'Select rental duration',
            ),
            decoration: InputDecorations.defaultDecoration(
                hintText: 'Select rental duration'),
          ),
        );
      },
    );
  }
}
