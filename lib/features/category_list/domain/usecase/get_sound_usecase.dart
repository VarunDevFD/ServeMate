import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/sound_model.dart';
import 'package:serve_mate/features/category_list/domain/repository/repo_category.dart';

class GetSoundUsecase {
  final repository = serviceLocator<H2CategoryRepository>();

  Future<List<SoundModel>> call() async {
    return await repository.getSounds();
  }

  Future<bool> update(String dId, SoundModel model) async {
    return await repository.updateSound(dId, model);
  }
}
