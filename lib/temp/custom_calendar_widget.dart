// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:serve_mate/core/theme/app_colors.dart';
// import 'package:serve_mate/features/product/presentation/bloc/calender_bloc/calender_bloc.dart';
// import 'package:serve_mate/features/product/presentation/bloc/calender_bloc/calender_state.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CustomCalendar extends StatelessWidget {
//   final Function(DateTime selectedDate, DateTime focusedDay) onDaySelected;
//   const CustomCalendar({Key? key, required this.onDaySelected})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DateBloc, DateState>(builder: (context, state) {
//       return TableCalendar(
//         calendarStyle: CalendarStyle(
//           todayDecorationEntity: BoxDecorationEntity(
//             color: AppColors.orange,
//             shape: BoxShape.circle,
//           ),
//           selectedDecorationEntity: BoxDecorationEntity(
//             color: AppColors.green,
//             shape: BoxShape.circle,
//           ),
//         ),
//         firstDay: kFirstDay,
//         lastDay: kLastDay,
//         focusedDay: state.selectedDate ?? kToday,
//         calendarFormat: state.calendarFormat,
//         enabledDayPredicate: (day) => day.isAfter(
//           kToday.subtract(const Duration(days: 1)),
//         ),
//         onDaySelected: (selectedDate, focusedDay) {
//           if (selectedDate.isAfter(kToday.subtract(const Duration(days: 1)))) {
//             onDaySelected(selectedDate, focusedDay);
//             context.pop();
//           }
//         },
//         headerStyle: const HeaderStyle(
//           formatButtonVisible: false, // Hides the FormatButton
//         ),
//       );
//     });
//   }
// }

// final kToday = DateTime.now();
// final kFirstDay = DateTime(kToday.year, kToday.month, kToday.day);
// final kLastDay = DateTime(kToday.year, kToday.month + 6, kToday.day);

// // ValueNotifier to track the current CalendarFormat
// final ValueNotifier<CalendarFormat> calendarFormatNotifier =
//     ValueNotifier(CalendarFormat.week);

// // Function to display the calendar modal
// Future<void> showCalendarModal({
//   required BuildContext context,
//   required TextEditingController dateAddedController,
// }) async {
//   await showModalBottomSheet(

//     context: context,
//     isScrollControlled: true,
//     builder: (context) => DraggableScrollableSheet(
//       expand: false,
//       initialChildSize: 0.18,
//       minChildSize: 0.15,
//       maxChildSize: 0.4,
//       builder: (context, scrollController) {
//         return NotificationListener<DraggableScrollableNotification>(
//           onNotification: (notification) {
//             // Change the CalendarFormat based on the scroll extent
//             if (notification.extent >= 0.25) {
//               calendarFormatNotifier.value = CalendarFormat.month;
//             } else if (notification.extent >= 0.16) {
//               calendarFormatNotifier.value = CalendarFormat.twoWeeks;
//             } else {
//               calendarFormatNotifier.value = CalendarFormat.week;
//             }
//             return true;
//           },
//           child: SingleChildScrollView(
//             controller: scrollController,
//             child: ValueListenableBuilder<CalendarFormat>(
//               valueListenable: calendarFormatNotifier,
//               builder: (context, calendarFormat, _) {
//                 return TableCalendar(
//                   firstDay: kFirstDay,
//                   lastDay: kLastDay,
//                   focusedDay: kToday,
//                   calendarStyle: CalendarStyle(
//                     todayDecorationEntity: BoxDecorationEntity(
//                       color: AppColors.orange,
//                       shape: BoxShape.circle,
//                     ),
//                     selectedDecorationEntity: BoxDecorationEntity(
//                       color: AppColors.orange1,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   calendarFormat: calendarFormat,
//                   enabledDayPredicate: (day) =>
//                       day.isAfter(kToday.subtract(const Duration(days: 1))),
//                   selectedDayPredicate: (day) {
//                     return false;
//                   },
//                   headerStyle: const HeaderStyle(
//                     formatButtonVisible: false, // Hides the FormatButton
//                   ),
//                   onDaySelected: (selectedDay, focusedDay) {
//                     // Format ("dd-MM-yyyy")
//                     final formattedDate =
//                         "${selectedDay.day.toString().padLeft(2, '0')}-"
//                         "${selectedDay.month.toString().padLeft(2, '0')}-"
//                         "${selectedDay.year}";

//                     dateAddedController.text = formattedDate;
//                     context.pop(); // Close the sheet
//                   },
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }
