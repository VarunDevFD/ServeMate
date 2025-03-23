 

import 'package:flutter_bloc/flutter_bloc.dart';

class TabTogglCubit extends Cubit<int> {
  TabTogglCubit() : super(0); // Initial selected index is 0

  void selectTab(int index) {
    // log('Emitting index: $index'); 
    emit(index); // Emits the new selected tab index
  }
}
