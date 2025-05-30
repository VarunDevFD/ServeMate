import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/jewelry_model.dart';
import 'package:serve_mate/features/category_list/domain/repository/repo_category.dart';

class GetJewelrysUsecase {
  final repository = serviceLocator<H2CategoryRepository>();

  Future<List<JewelryModel>> call() async {
    return await repository.getJewelry();
  }

  Future<bool> update(String dId, JewelryModel model) async {
    return await repository.updateJewelry(dId, model);
  }
}
