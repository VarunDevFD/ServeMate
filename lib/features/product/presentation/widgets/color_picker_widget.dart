import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/utils/color_utils.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_state.dart';

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DressFormBloc, DressFormState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  titlePadding: const EdgeInsets.all(10),
                  contentPadding: const EdgeInsets.all(2),
                  title: const Text('Choose a color'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      paletteType: PaletteType.hslWithSaturation,
                      pickerColor: state.selectedColor,
                      onColorChanged: (color) {
                        // ignore: deprecated_member_use
                        final colorName = getColorRange(color.value);
                        context
                            .read<DressFormBloc>()
                            .add(ColorChanged(color, colorName));
                      },
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Got it'),
                      onPressed: () => context.pop(),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: state.selectedColor,
            ),
            child: Icon(
              Icons.auto_fix_high,
              color: useWhiteForeground(state.selectedColor)
                  ? AppColors.white
                  : AppColors.black,
              size: 18,
            ),
          ),
        );
      },
    );
  }
}
