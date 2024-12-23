import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
// import 'package:serve_mate/features/category/domain/entities/category_entities.dart';
import 'package:serve_mate/features/category/domain/usecases/get_categories.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final categoryRepository = serviceLocator<GetCategories>();
  CategoryBloc() : super(CategoryInitial()) {
    // Add Category
    on<SelectCategoryEvent>((event, emit) async {
      final pref = serviceLocator<PreferencesRepository>();

      emit(CategoryInitial());

      try {
        await pref.setDataFn(event.selectedCategory);
    
        String? response = await pref.getDataFn();

        if (response != null) {
          emit(CategoryLoaded(categoryName: response));
          log('Category saved successfully: $response');
        } else {
          response = 'Invalid Category';
          emit(CategoryLoaded(categoryName: response));
        }
      } catch (e) {
        // Handle any errors and emit the error state.
        emit(CategoryError("Failed to save category: ${e.toString()}"));
        log('Error: ${e.toString()}');
      }
    });

    // Read Category
    on<LoadCategoriesEvent>((event, emit) async {
      emit(CategoryInitial());
      try {
        final categories = await categoryRepository.callCategory();
        emit(CategoryLoaded(categories: categories));
      } catch (e) {
        emit(CategoryError("Failed to Fetch load categories"));
      }
    });
  }
}
