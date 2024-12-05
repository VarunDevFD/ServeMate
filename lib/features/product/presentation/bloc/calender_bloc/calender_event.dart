import 'package:table_calendar/table_calendar.dart';

class DateEvent {}

class DateSelected extends DateEvent {
  final DateTime selectedDate;

  DateSelected(this.selectedDate);
}

class InvalidDateSelected extends DateEvent {}

class CalendarFormatChanged extends DateEvent {
  final CalendarFormat calendarFormat;

  CalendarFormatChanged(this.calendarFormat);
}
