// Widget _buildColorPicker() {
//     return BlocBuilder<DressFormBloc, DressFormState>(
//       builder: (context, state) {
//         return GestureDetector(
//           onTap: () {
//             showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   titlePadding: const EdgeInsets.all(10),
//                   contentPadding: const EdgeInsets.all(2),
//                   title: const Text(
//                     'Choose a color',
//                     style: TextStyle(
//                       color: AppColors.black,
//                     ),
//                   ),
//                   content: SingleChildScrollView(
//                     child: ColorPicker(
//                       paletteType: PaletteType.hslWithSaturation,
//                       pickerColor: state.selectedColor,
//                       onColorChanged: (color) {
//                         // Get the color name based on the selected color
//                         final colorName = getColorRange(color.value);

//                         // Dispatch the event with both color and color name
//                         context
//                             .read<DressFormBloc>()
//                             .add(ColorChanged(color, colorName));
//                       },
//                     ),
//                   ),
//                   actions: <Widget>[
//                     TextButton(
//                       child: const Text('Got it'),
//                       onPressed: () {
//                         context.pop();
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Color(
//                   hexToColor(state.colorName)), // Display the selected color
//             ),
//             child: Icon(
//               Icons.auto_fix_high,
//               color: useWhiteForeground(state.selectedColor)
//                   ? Colors.white
//                   : Colors.black,
//               size: 18,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }