// carousel_bloc.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:serve_mate/features/home/presentation/bloc/carousel_slide_bloc/carousel_slide_bloc_event.dart';
import 'package:serve_mate/features/home/presentation/bloc/carousel_slide_bloc/carousel_slide_bloc_state.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  int currentIndex = 0;
  final int totalItems;
  Timer? _timer;

  CarouselBloc(this.totalItems) : super(CarouselInitial()) {
    on<NextCarouselEvent>((event, emit) {
      currentIndex = (currentIndex + 1) % totalItems; // Cycle through items
      emit(CarouselUpdated(currentIndex)); // Emit the updated state
    });
  }

  // Start the periodic timer to trigger next carousel slide every 5 seconds
  void startCarousel() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      add(NextCarouselEvent());
    });
  }

  // Stop the carousel (cancel the timer)
  void stopCarousel() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Cancel the timer before closing the bloc
    return super.close();
  }
}
