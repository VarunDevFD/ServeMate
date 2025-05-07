import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/vehicle_model.dart';
import 'package:serve_mate/features/category_list/domain/repository/repo_category.dart';

class GetVehiclesUsecase {
  final repository = serviceLocator<H2CategoryRepository>();

  Future<List<VehicleModel>> call() async {
    return await repository.getVehicles();
  }

  Future<void> update(String dId, VehicleModel model) async {
    return await repository.updateVehicle(dId, model);
  }
}
