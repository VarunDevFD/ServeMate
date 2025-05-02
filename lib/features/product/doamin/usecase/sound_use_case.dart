import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/product/doamin/entities/sound.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class SoundUseCase {
  final repository = serviceLocator<ProductRepository>();


  Future<Either<String, String>> execute(Sound sound) async {
    return await repository.addSound(sound);
  }

  Future<List<Sound>> fetchSound() async {
    return await repository.fetchSound();
  }
}
