import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';

class UpdateCategory {
  
  final CategoryRepository repository;

  UpdateCategory(this.repository);
 

  Future<void> call(String name) async {
    return await repository.selectCategory(name);
  }
}
