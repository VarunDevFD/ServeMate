abstract class NavigationState {}

class NavigationInitial extends NavigationState {
  final int pageIndex;

  NavigationInitial(this.pageIndex);
}

class NavigationPageChanged extends NavigationState {
  final int pageIndex;

  NavigationPageChanged(this.pageIndex);
}
