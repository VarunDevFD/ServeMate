import 'package:serve_mate/features/category/domain/entities/category.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  final Category? selectedCategory;

  CategoryLoaded(this.categories, [this.selectedCategory]);
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}
