import 'package:serve_mate/features/category/domain/entities/category_entities.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<void> selectCategory(String categoryName);
}
