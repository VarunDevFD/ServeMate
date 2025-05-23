import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/footwear_model.dart';
import 'package:serve_mate/features/home/domain/repository/domain_home_category_repository.dart';

class FootwearUsecaseHome {
  final repository = serviceLocator<HomeCategoryRepository>();

  Future<List<FootwearModel>> call() async {
    return await repository.getFootwear();
  }
}
