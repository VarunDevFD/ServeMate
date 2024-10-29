import 'package:serve_mate/features/category/domain/entities/category.dart';
import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository repository;

  GetCategories(this.repository);

  Future<List<Category>> call() async {
    return repository.getCategories();
  }
}
