import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/decoration_model.dart';
import 'package:serve_mate/features/home/domain/repository/domain_home_category_repository.dart';

class DecorationUsecaseHome {
  final repository = serviceLocator<HomeCategoryRepository>();

  Future<List<DecorationModel>> call() async {
    return await repository.getDecorations();
  }
}
