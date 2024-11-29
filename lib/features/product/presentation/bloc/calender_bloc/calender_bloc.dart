import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/calender_bloc/calender_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/calender_bloc/calender_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  DateBloc() : super(const DateState()) {
    on<DateSelected>((event, emit) {
      emit((DateState(
        selectedDate: event.selectedDate,
      )));
    });

    on<CalendarFormatChanged>((event, emit) {
      emit(DateState(
        calendarFormat: event.calendarFormat,
      ));
    });
  }
}
