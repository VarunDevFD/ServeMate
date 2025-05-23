import 'dart:async';
import 'package:bloc/bloc.dart'; 

part 'sponsor_scroller_event.dart';
part 'sponsor_scroller_state.dart';

class SponsorScrollerBloc extends Bloc<SponsorScrollerEvent, SponsorScrollerState> {
  final int itemCount;
  Timer? _timer;

  SponsorScrollerBloc({required this.itemCount}) : super(const SponsorScrollerState(0)) {
    on<NextSponsorPageEvent>((event, emit) {
      int nextPage = (state.currentPage + 1) % itemCount;
      emit(SponsorScrollerState(nextPage));
    });

    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      add(NextSponsorPageEvent());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
