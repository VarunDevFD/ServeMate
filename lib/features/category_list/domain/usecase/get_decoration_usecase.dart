import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/decoration_model.dart';
import 'package:serve_mate/features/category_list/domain/repository/repo_category.dart';

class GetDecorationUsecase {
  final repository = serviceLocator<H2CategoryRepository>();

  Future<List<DecorationModel>> call() async {
    return await repository.getDecorations();
  }

  Future<void> update(String dId, DecorationModel model) async {
    return await repository.updateDecoration(dId, model);
  }
}
