import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/vehicle_model.dart';
import 'package:serve_mate/features/home/domain/repository/domain_home_category_repository.dart';

class VehicleUsecaseHome {
  final repository = serviceLocator<HomeCategoryRepository>();
  Future<List<VehicleModel>> call() async {
    return await repository.getVehicles();
  }
}
