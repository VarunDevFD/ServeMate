import 'package:serve_mate/features/home/presentation/pages/category.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategorySelected extends CategoryState {
  final WeddingCategory category;
  CategorySelected(this.category);
}
