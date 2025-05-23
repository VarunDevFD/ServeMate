import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/home/domain/repository/domain_home_category_repository.dart';

class GetUserCategorysListUsecase {
   final repository = serviceLocator<HomeCategoryRepository>(); 

  Future<Map<String, bool>> call({required String uid}) async {
    return await repository.getUserCategories(userId: uid);
  }
}
