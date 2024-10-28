import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/home/presentation/bloc/category_bloc/category_event.dart';
import 'package:serve_mate/features/home/presentation/bloc/category_bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial());

  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is SelectCategory) {
      // Yield the selected category state
      yield CategorySelected(event.category);
    }
  }
}
