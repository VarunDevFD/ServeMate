import 'package:serve_mate/features/category/domain/entities/category_entities.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category>? categories;
  final String? categoryName;

  CategoryLoaded({this.categories, this.categoryName});
}

class CategorySaved extends CategoryState {}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}
