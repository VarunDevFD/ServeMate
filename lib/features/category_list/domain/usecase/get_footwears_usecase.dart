import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/footwear_model.dart';
import 'package:serve_mate/features/category_list/domain/repository/repo_category.dart';

class GetFootwearsUsecase {
  final repository = serviceLocator<H2CategoryRepository>();

  Future<List<FootwearModel>> call() async {
    return await repository.getFootwear();
  }
}
