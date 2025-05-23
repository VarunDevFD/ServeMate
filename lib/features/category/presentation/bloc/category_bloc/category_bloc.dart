import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';
import 'package:serve_mate/features/category/domain/usecases/save_category.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final categoryRepository = serviceLocator<CategoryRepository>();
  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<SelectCategoryEvent>(_onCategorySelected);
    add(LoadCategoriesEvent());
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

  void _onCategorySelected(
      SelectCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(CategoryLoading());
      final save = serviceLocator<SaveCategory>();

      final selectedCategory = event.category;
      
      await save.call(selectedCategory);

      emit(CategorySelected());
    } catch (e) {
      emit(CategoryError('Failed to load category'));
    }
  }
}