// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
// import 'package:serve_mate/core/theme/app_colors.dart';
// import 'package:serve_mate/features/product/presentation/bloc/tab_toggle_button.dart/bloc.dart';
// import 'package:serve_mate/features/product/presentation/widgets/custom_toggle_button_widget.dart';

// Widget buildToggleContainerTextField(
//     BuildContext context, String hint, onToggleSelected) {
//   final vehicleAvailable = TabTogglCubit();

//   return BlocBuilder<TabTogglCubit, int>(
//       bloc: vehicleAvailable,
//       builder: (context, selectedIndex) {
//         final selectedValue = DropdownItems.vehicleToggleList[selectedIndex];
//         return Container(
//           margin: EdgeInsets.symmetric(vertical: 6.h),
//           padding: EdgeInsets.all(8.r),
//           height: 40.h,
//           width: 400.w,
//           DecorationEntity: BoxDecorationEntity(
//             color: AppColors.transparent,
//             border: Border.all(width: 0.5.w, color: AppColors.grey),
//             borderRadius: BorderRadius.circular(4.r),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               const SizedBox(),
//               Expanded(
//                 child: Text(
//                   "Available : ${selectedValue.isNotEmpty ? selectedValue : hint}",
//                   style: TextStyle(fontSize: 12.sp, color: AppColors.black),
//                 ),
//               ),
//               SizedBox(
//                 width: 10.w,
//               ),
//               CustomToggleButton(
//                 onToggleSelected: onToggleSelected,
//                 toggleList: DropdownItems.vehicleToggleList,
//                 bloc: vehicleAvailable,
//               ),
//             ],
//           ),
//         );
//       });
// }
