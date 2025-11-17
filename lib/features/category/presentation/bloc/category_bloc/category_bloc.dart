import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/features/category/domain/usecases/get_categorys_usecase.dart';
import 'package:serve_mate/features/category/domain/usecases/save_category.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final getCategories = serviceLocator<GetCategories>();
  final updateCategory = serviceLocator<UpdateCategory>();

  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<SelectCategoryEvent>(_onSelectCategory);

    add(LoadCategoriesEvent());
  }

  Future<void> _onLoadCategories(
    LoadCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    await Future.delayed(const Duration(seconds: 3));
    try {
      // final categories = await getCategories();
      const categories = VList.categoryList;
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError("Failed to load categories"));
    }
  }

  Future<void> _onSelectCategory(
    SelectCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    await updateCategory(event.category);
    emit(CategorySelected());
  }
}
