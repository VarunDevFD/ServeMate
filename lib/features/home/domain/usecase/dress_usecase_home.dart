import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/dress_model.dart';
import 'package:serve_mate/features/home/domain/repository/domain_home_category_repository.dart';

class DressUsecaseHome {
  final repository = serviceLocator<HomeCategoryRepository>();

  Future<List<DressModel>> call() async {
     return await repository.getDresses();
  }
}
