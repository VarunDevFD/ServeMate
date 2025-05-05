import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/category_list/domain/repository/repo_category.dart';

class DeleteCategoryItems {
  final repository = serviceLocator<H2CategoryRepository>();
  Future<void> call(String collectionName, String documentId) async {
    return await repository.deleteDocument(
        collectionName: collectionName, documentId: documentId);
  }
}
