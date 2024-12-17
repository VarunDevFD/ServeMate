import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/error/failure.dart';
import 'package:serve_mate/features/category/domain/entities/category_entities.dart';

abstract class CategoryRepository {
  /// Fetches all available categories
  Future<List<Category>> getCategories();
  Future<Either<Failure, void>> saveCategory(Category category);

  /// Updates the selected category for a user in the database
  // Future<void> addUserCategory({
  //   required String userId,
  //   required String category,
  // });
}
