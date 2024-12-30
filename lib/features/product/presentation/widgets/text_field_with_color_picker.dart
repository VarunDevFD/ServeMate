import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/color_utils.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/theme/input_decoration.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_state.dart';

import 'color_picker_widget.dart';

class TextFieldWithColorPicker extends StatelessWidget {
  final String hint;
  final ValueChanged<TextEditingController?> onColorSelected;

  const TextFieldWithColorPicker(
      {super.key, required this.hint, required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DressFormBloc, DressFormState>(
      builder: (context, state) {
        final controller = TextEditingController(text: state.colorName);

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h),
          child: TextFormField(
            cursorColor: AppColors.black,
            controller: controller,
            onChanged: (text) {
              final color = getColorByName(text);
              if (color != null) {
                TextEditingController controller =
                    TextEditingController(text: text);
                context
                    .read<DressFormBloc>()
                    .add(ColorChanged(color, controller.text));
                onColorSelected(controller);
              }
            },
            decoration: InputDecorations.defaultDecoration(
              suffixIcon: Padding(
                padding: EdgeInsets.all(8.0.r),
                child: const ColorPickerWidget(),
              ),
            ),
          ),
        );
      },
    );
  }
}
