import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/category/data/data_source/data_source_category.dart';
import 'package:serve_mate/features/category/domain/entities/category_entities.dart';
import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final remoteDataSource = serviceLocator<DataSourceCategory>();

  @override
  Future<List<Category>> getCategories() async {
    return remoteDataSource.fetchCategories();
  }

  @override
  Future<void> selectCategory(String categoryName) async {
    return remoteDataSource.updateCategoryName(categoryName);
  }
}
