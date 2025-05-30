import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/features/category_list/domain/repository/repo_category.dart'; 

class GetCamerasUseCase {
  final repository = serviceLocator<H2CategoryRepository>();

  Future<List<CameraModel>> call() async {
    return await repository.getCameras();
  }

  Future<bool> update(String dId, CameraModel model) async {
      return await repository.updateCamera(dId, model);
  }
} 