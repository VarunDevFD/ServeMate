import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/theme/input_decoration.dart';
import 'package:serve_mate/features/product/presentation/bloc/dropdown_bloc/dropdown_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/dropdown_bloc/dropdown_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/dropdown_bloc/dropdown_state.dart';

class ReusableDropdown extends StatelessWidget {
  final ValueChanged<String> onDataSelected;
  final DropdownBloc bloc;
  final List items;
  final String hint;

  const ReusableDropdown({
    Key? key,
    required this.bloc,
    required this.items,
    required this.hint,
    required this.onDataSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownBloc, DropdownState>(
      bloc: bloc,
      builder: (context, state) {
        String? selectedValue;
        if (state is DropdownValueChangedState) {
          selectedValue = state.selectedValue;
        }

        final dropdownItems = items
            .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(value.toString()),
                ))
            .toList();

        return DropdownButtonFormField(
          value: dropdownItems.any((item) => item.value == selectedValue)
              ? selectedValue
              : null,
          validator: (value) {
            if (value == null) {
              return 'Please select an option';
            }
            return null;
          },
          items: dropdownItems,
          hint: Text(hint),
          decoration: InputDecorations.defaultDecoration(),
          alignment: Alignment.centerLeft,
          menuMaxHeight: 200,
          onChanged: (newValue) {
            if (newValue != null && newValue is String) {
              bloc.add(DropdownValueChangedEvent(newValue));
              onDataSelected(newValue);
            }
          },
        );
      },
    );
  }
}
