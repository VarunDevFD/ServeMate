import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/error/failure.dart';
import 'package:serve_mate/features/category/domain/entities/category_entities.dart';
import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';

class GetCategories {
  final repository = serviceLocator<CategoryRepository>();

  Future<List<Category>> callCategory() async {
    return repository.getCategories();
  }

  Future<Either<Failure, void>> callSaveCategory(Category category) {
    return repository.saveCategory(category);
  }
}
