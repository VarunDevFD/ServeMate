import 'package:serve_mate/features/category/domain/entities/category.dart';

abstract class CategoryEvent {}

class LoadCategoriesEvent extends CategoryEvent {}

class SelectCategoryEvent extends CategoryEvent {
  final Category category;

  SelectCategoryEvent(this.category);
}
