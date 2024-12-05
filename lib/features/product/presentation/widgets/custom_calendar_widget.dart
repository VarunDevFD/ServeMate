import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/utils/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/calender_bloc/calender_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/calender_bloc/calender_state.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatelessWidget {
  final Function(DateTime selectedDate, DateTime focusedDay) onDaySelected;
  const CustomCalendar({Key? key, required this.onDaySelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateBloc, DateState>(builder: (context, state) {
      return TableCalendar(
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppColors.orange,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: AppColors.green,
            shape: BoxShape.circle,
          ),
        ),
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: state.selectedDate ?? kToday,
        calendarFormat: state.calendarFormat,
        enabledDayPredicate: (day) => day.isAfter(
          kToday.subtract(const Duration(days: 1)),
        ),
        onDaySelected: (selectedDate, focusedDay) {
          if (selectedDate.isAfter(kToday.subtract(const Duration(days: 1)))) {
            onDaySelected(selectedDate, focusedDay);
            context.pop();
          }
        },
        headerStyle: const HeaderStyle(
          formatButtonVisible: false, // Hides the FormatButton
        ),
      );
    });
  }
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
