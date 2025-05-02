import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class CameraUseCase {
  final repository = serviceLocator<ProductRepository>();

  Future<Either<String, String>> execute(Camera camera) async {
    return await repository.addCamera(camera);
  }
}
