import 'package:serve_mate/features/category/data/data_source/data_source_category.dart';
import 'package:serve_mate/features/category/domain/entities/category_entities.dart';
import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final DataSourceCategory dataSource;

  CategoryRepositoryImpl({required this.dataSource});

  @override
  Future<List<Category>> getCategories() async {
    return dataSource.fetchCategories();
  }

  @override
  Future<void> selectCategory(String categoryName) async {
    return dataSource.updateCategoryName(categoryName);
  }
}
