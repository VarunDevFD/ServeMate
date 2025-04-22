import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';

class SaveCategory {
  final repository = serviceLocator<CategoryRepository>();

  Future<void> call(String category) async {
    return await repository.selectCategory(category);
  }
}
