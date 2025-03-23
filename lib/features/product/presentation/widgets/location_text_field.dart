// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:serve_mate/core/theme/app_colors.dart';
// import 'package:serve_mate/core/theme/input_decoration.dart';
// import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
// import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_event.dart';
// import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';

// Widget buildLocationTextField({
//   required BuildContext context,
//   required String hint,
//   required String Function(String?) validator,
//   required Function(TextEditingController? controller) locationController,
// }) {
//   return Padding(
//     padding: EdgeInsets.only(top: 8.h),
//     child: BlocBuilder<LocationBloc, LocationState>(
//       builder: (context, state) {
//         // Create the TextEditingController and update it when location changes
//         TextEditingController controller = TextEditingController(
//           text: state.placeName ?? "", // Default text from state
//         );

//         return TextFormField(
//           controller: controller,
//           cursorColor: AppColors.balck1,
//           decoration: InputDecorations.defaultDecoration(
//             hintText: hint,
//             suffixIcon: IconButton(
//               icon: const Icon(Icons.location_on),
//               onPressed: () {
//                 BlocProvider.of<LocationBloc>(context)
//                     .add(FetchCurrentLocation());
//               },
//             ),
//             errorText: state.locationError, // Show error if present
//           ),
//           readOnly: true, //Allow user interaction
//           onChanged: (value) {
//             locationController(controller); // Update external controller
//           },
//           validator: validator,
//         );
//       },
//     ),
//   );
// }
