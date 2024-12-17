import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/error/failure.dart';
import 'package:serve_mate/features/category/data/datasource/category_remote_datasource_data.dart';
import 'package:serve_mate/features/category/data/models/category_model.dart';
import 'package:serve_mate/features/category/domain/entities/category_entities.dart';
import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final remoteDataSource = serviceLocator<CategoryRemoteDataSource>();

  @override
  Future<List<Category>> getCategories() async {
    try {
      return await remoteDataSource.fetchCategories();
    } catch (e) {
      rethrow; // Pass the exception to the Bloc layer to handle
    }
  }

  @override
  Future<Either<Failure, void>> saveCategory(Category category) async {
    try {
      final categoryModel = CategoryModel(
        name: category.name,
        imageUrl: "Null",
        userId: category.userId,
      );
      await remoteDataSource.saveCategory(
          categoryModel.name, categoryModel.imageUrl, categoryModel.userId!);
      return const Right(null);
    } catch (e) {
      return const Left(Failure(message: 'Failed to save category'));
    }
  }
}
