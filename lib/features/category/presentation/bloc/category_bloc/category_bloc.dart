import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/category/domain/usecases/get_categories.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final categoryRepository = serviceLocator<GetCategories>();
  CategoryBloc() : super(CategoryInitial()) {
    // Event handlers
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<SelectCategoryEvent>(_onSelectCategory);
  }

  Future<void> _onLoadCategories(
      LoadCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryInitial());
    try {
      final categories =
          await categoryRepository.callCategory(); // Fetch Categories
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError("Failed to Fetch load categories"));
    }
  }

  Future<void> _onSelectCategory(
      SelectCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryInitial());
    try {
      final firestore = serviceLocator<FirebaseFirestore>();

      // Retrieve the `userId` from the existing collection
      final userDoc =
          await firestore.collection('users').doc('KDknbCv20BqtW73G6TPJ').get();
      final userId = userDoc.data()?['uid'];

      // Save selected category to Firebase collection
      firestore.collection('Categories').doc().set({
        'name': event.selectedCategory,
        'userId': userId,
      });
      emit(CategorySaved());
    } catch (e) {
      emit(CategoryError("Failed to save category: ${e.toString()}"));
    }
  }
}
