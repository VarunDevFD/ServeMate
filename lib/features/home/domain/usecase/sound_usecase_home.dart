import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/sound_model.dart';
import 'package:serve_mate/features/home/domain/repository/domain_home_category_repository.dart';

class SoundUsecaseHome {
  final repository = serviceLocator<HomeCategoryRepository>();

  Future<List<SoundModel>> call() async {
    return await repository.getSounds();
  }
}
