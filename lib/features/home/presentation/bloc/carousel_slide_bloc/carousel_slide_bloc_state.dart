abstract class CarouselState {}

class CarouselInitial extends CarouselState {}

class CarouselUpdated extends CarouselState {
  final int currentIndex;

  CarouselUpdated(this.currentIndex);
}
