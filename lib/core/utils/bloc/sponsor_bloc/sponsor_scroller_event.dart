part of 'sponsor_scroller_bloc.dart';

abstract class SponsorScrollerEvent {
  const SponsorScrollerEvent();

  @override
  List<Object?> get props => [];
}

class NextSponsorPageEvent extends SponsorScrollerEvent {}
