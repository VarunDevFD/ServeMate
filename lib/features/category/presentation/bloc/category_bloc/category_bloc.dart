import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository =
      serviceLocator<CategoryRepository>(); // Initialize directly
  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<SelectCategory>(_onSelectCategory);
  }

  Future<void> _onLoadCategories(
      LoadCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final categories = await categoryRepository
          .getCategories(); // Fetch categories from repository
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError("Failed to load categories"));
    }
  }

  void _onSelectCategory(SelectCategory event, Emitter<CategoryState> emit) {
    // Handle category selection
    // You might want to emit a state or perform additional actions here
  }
}
