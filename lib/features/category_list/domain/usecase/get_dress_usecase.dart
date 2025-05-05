import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/dress_model.dart';
import 'package:serve_mate/features/category_list/domain/repository/repo_category.dart';

class GetDressUsecase {
  final repository = serviceLocator<H2CategoryRepository>();

  Future<List<DressModel>> call() async {
    return await repository.getDresses();
  }
}
