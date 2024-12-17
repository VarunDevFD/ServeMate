abstract class CategoryEvent {}

// Load Category
class LoadCategoriesEvent extends CategoryEvent {}

// Select a category save also
class SelectCategoryEvent extends CategoryEvent {
  final String selectedCategory;

  SelectCategoryEvent(this.selectedCategory);
}


