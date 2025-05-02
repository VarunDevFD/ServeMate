// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:serve_mate/core/theme/app_colors.dart';
// import 'package:serve_mate/core/theme/input_DecorationEntity.dart';
// import 'package:serve_mate/features/product/presentation/bloc/calender_bloc/calender_bloc.dart';
// import 'package:serve_mate/features/product/presentation/bloc/calender_bloc/calender_event.dart';
// import 'package:serve_mate/features/product/presentation/bloc/calender_bloc/calender_state.dart';
// import 'package:serve_mate/features/product/presentation/widgets/custom_calendar_widget.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarPickerWidget extends StatelessWidget {
//   final ValueChanged<String> onDateSelected;

//   const CalendarPickerWidget({super.key, required this.onDateSelected});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DateBloc, DateState>(
//       builder: (context, state) {
//         final String defaultDate = state.selectedDate != null
//             ? DateFormat('dd/MM/yyyy').format(state.selectedDate!)
//             : DateFormat('dd/MM/yyyy').format(kToday);
//         final controller = TextEditingController(text: defaultDate);
//         return Column(
//           children: [
//             TextFormField(
//               controller: controller,
//               cursorColor: AppColors.black,
//               DecorationEntity: InputDecorationEntitys.defaultDecorationEntity(
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.calendar_month_outlined),
//                   onPressed: () {
//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       builder: (context) => DraggableScrollableSheet(
//                         expand: false,
//                         initialChildSize: 0.25,
//                         minChildSize: 0.25,
//                         maxChildSize: 0.4, // Full screen height
//                         builder: (context, scrollController) {
//                           return NotificationListener<
//                               DraggableScrollableNotification>(
//                             onNotification: (notification) {
//                               final double extent = notification.extent;
//                               if (extent == 0.25) {
//                                 context.read<DateBloc>().add(
//                                     CalendarFormatChanged(
//                                         CalendarFormat.twoWeeks));
//                               } else if (extent > 0.3 && extent < 0.4) {
//                                 context.read<DateBloc>().add(
//                                     CalendarFormatChanged(
//                                         CalendarFormat.month));
//                               }

//                               return true; // Consume the notification
//                             },
//                             child: SingleChildScrollView(
//                               controller: scrollController,
//                               child: CustomCalendar(
//                                 onDaySelected: (selectedDate, focusedDay) {
//                                   if (selectedDate.isAfter(kToday
//                                       .subtract(const Duration(days: 1)))) {
//                                     onDateSelected(
//                                       DateFormat('dd/MM/yyyy')
//                                           .format(selectedDate),
//                                     );
//                                     context
//                                         .read<DateBloc>()
//                                         .add(DateSelected(selectedDate));
//                                   } else {
//                                     context
//                                         .read<DateBloc>()
//                                         .add(InvalidDateSelected());
//                                   }
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       )
//                           .animate()
//                           .fade(duration: 500.ms, begin: 0.05)
//                           .slideY(begin: 0.2),
//                     );
//                   },
//                 ),
//               ),
//               readOnly: true,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please select a date';
//                 }
//                 onDateSelected(controller.text);
//                 return null;
//               },
//             )
//           ],
//         );
//       },
//     );
//   }
// }
