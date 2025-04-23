
abstract class CategoryEvent {}

class LoadCategoriesEvent extends CategoryEvent {}

class SelectCategoryEvent extends CategoryEvent {
  final String category;

  SelectCategoryEvent(this.category);
}