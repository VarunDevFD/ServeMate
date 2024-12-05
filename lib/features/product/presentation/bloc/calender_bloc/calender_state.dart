import 'package:table_calendar/table_calendar.dart';

class DateState {
  final DateTime? selectedDate;
  final CalendarFormat   calendarFormat;

  const DateState({
    this.selectedDate,
    this.calendarFormat = CalendarFormat.twoWeeks,
  });
}
