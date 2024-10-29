abstract class CategoryEvent {}

class LoadCategoriesEvent extends CategoryEvent {}

class SelectCategory extends CategoryEvent {
  final String categoryName;

  SelectCategory(this.categoryName);
}
