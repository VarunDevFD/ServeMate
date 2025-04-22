import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';
import 'package:serve_mate/features/category/domain/usecases/save_category.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final categoryRepository = serviceLocator<GetCategories>();
  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<SelectCategoryEvent>(_onCategorySelected);
    add(LoadCategoriesEvent());
  }

      emit(CategoryInitial());

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
