// navigation_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_nav_bar_event.dart';
import 'bottom_nav_bar_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial(0)) {
    // Register handlers for events
    on<PageChangedEvent>((event, emit) {
      // Emit the new state when the page changes
      emit(NavigationPageChanged(event.index));
    });

    on<PageTappedEvent>((event, emit) {
      // Emit the new state when the user taps on the bottom navigation bar
      emit(NavigationPageChanged(event.index));
    });
  }
}
