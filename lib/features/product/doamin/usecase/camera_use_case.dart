import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class CameraUseCase {
  final ProductRepository repository;

  CameraUseCase(this.repository);

  Future<void> execute(Camera camera) async { 
    return await repository.addCamera(camera);
    
  }
   

  Future<List<Camera>> fetchCameras() async {
    return await repository.fetchCameras();
  }
}
