import 'package:serve_mate/features/home/presentation/pages/category.dart';

abstract class CategoryEvent {}

class SelectCategory extends CategoryEvent {
  final WeddingCategory category;
  SelectCategory(this.category);
}
