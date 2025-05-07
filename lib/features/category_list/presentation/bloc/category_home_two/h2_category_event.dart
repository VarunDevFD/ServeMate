abstract class H2CategoryEvent {}

class H2LoadCategories extends H2CategoryEvent {}

class SelectCategoryItemEvent extends H2CategoryEvent {
  final dynamic item;
  SelectCategoryItemEvent(this.item);
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

 

