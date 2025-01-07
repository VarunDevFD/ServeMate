abstract class NavigationEvent {}

class PageChangedEvent extends NavigationEvent {
  final int index;

  PageChangedEvent(this.index);
}

class PageTappedEvent extends NavigationEvent {
  final int index;

  PageTappedEvent(this.index);
}
