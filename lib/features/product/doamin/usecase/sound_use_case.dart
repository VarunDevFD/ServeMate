import 'package:serve_mate/features/product/doamin/entities/sound.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class SoundUseCase {
  final ProductRepository repository;

  SoundUseCase(this.repository);

  Future<void> execute(Sound sound) async {
    return await repository.addSound(sound);
  }

  Future<List<Sound>> fetchSound() async {
    return await repository.fetchSound();
  }
}
