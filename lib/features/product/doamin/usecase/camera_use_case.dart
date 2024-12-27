import 'package:serve_mate/features/product/doamin/entities/camera_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class AddCameraUseCase {
  final ProductRepository repository;

  AddCameraUseCase(this.repository);

  Future<void> execute(CameraEntity cameraEntity) async {
    return await repository.addCamera(cameraEntity);
  }
}
