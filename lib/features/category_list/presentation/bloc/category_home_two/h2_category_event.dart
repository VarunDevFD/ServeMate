abstract class H2CategoryEvent {}

class H2LoadCategories extends H2CategoryEvent {}

class SelectCategoryItemEvent extends H2CategoryEvent {
  final dynamic item;
  SelectCategoryItemEvent(this.item);
}

class CategoryDetailState extends H2CategoryEvent {
  final String itemName;
  final dynamic itemValue;
  CategoryDetailState(this.itemName, this.itemValue);
}

class DeleteCategoryEvent extends H2CategoryEvent {
  final String id;
  DeleteCategoryEvent(this.id);
}

class UpdateCategoryItemEvent extends H2CategoryEvent {
  final dynamic item;
  final String uid;
  UpdateCategoryItemEvent(this.item, this.uid);
}

class UpdateModelFinderEvent extends H2CategoryEvent {
  final dynamic item;
  UpdateModelFinderEvent(this.item);
}

// ------------ new events for the new category types ------------
class DetailsEvent extends H2CategoryEvent {
  final String itemName;
  final dynamic itemValue;
  final bool fromMain;
  DetailsEvent(this.itemName, this.itemValue, this.fromMain);
}

class InitialStageEvent extends H2CategoryEvent {}
