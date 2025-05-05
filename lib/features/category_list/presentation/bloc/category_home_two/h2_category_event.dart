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


class UpdateCategoryEvent extends H2CategoryEvent {
  final dynamic item;
  UpdateCategoryEvent(this.item);
}



