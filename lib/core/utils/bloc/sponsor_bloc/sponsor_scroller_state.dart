part of 'sponsor_scroller_bloc.dart';

class SponsorScrollerState {
  final int currentPage;

  const SponsorScrollerState(this.currentPage);

  @override
  List<Object?> get props => [currentPage];
}
