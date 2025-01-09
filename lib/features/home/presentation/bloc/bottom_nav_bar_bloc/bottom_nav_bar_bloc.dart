import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_nav_bar_event.dart';
import 'bottom_nav_bar_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(0)) {
    on<PageChangedEvent>((event, emit) {
      // Emit the new state when the page changes
      emit(NavigationState(event.index));
    });

    on<PageTappedEvent>((event, emit) {
      // Emit the new state when the user taps on the bottom navigation bar
      emit(NavigationState(event.index));
    });

    on<RestBottomNavBarEvent>((event, emit) {
      // Emit the return back initial page show on 
      emit(NavigationState(0));
    });
  }
}
