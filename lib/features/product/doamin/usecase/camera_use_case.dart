import 'package:serve_mate/features/product/doamin/entities/camera_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class CameraUseCase {
  final ProductRepository repository;

  CameraUseCase(this.repository);

  Future<void> execute(CameraEntity cameraEntity) async {
    return await repository.addCamera(cameraEntity);
  }

  Future<List<CameraEntity>> fetchCameras() async {
    return await repository.fetchCameras();
  }
}
