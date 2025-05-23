import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/features/home/domain/repository/domain_home_category_repository.dart';

class CameraUsecaseHome {
  final repository = serviceLocator<HomeCategoryRepository>();

   Future<List<CameraModel>> call() async {
    return await repository.getCameras();
  }
}