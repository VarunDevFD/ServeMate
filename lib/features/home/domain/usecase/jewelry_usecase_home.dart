import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/jewelry_model.dart';
import 'package:serve_mate/features/home/domain/repository/domain_home_category_repository.dart';

class JewelryUsecaseHome {
  final repository = serviceLocator<HomeCategoryRepository>();

  Future<List<JewelryModel>> call() async {
    return repository.getJewelry();
  }
}
