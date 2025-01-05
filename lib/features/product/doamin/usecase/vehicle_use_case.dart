import 'package:serve_mate/features/product/data/models/vehicle_model.dart';
import 'package:serve_mate/features/product/doamin/entities/vehicle_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class VehicleUseCase {
  final ProductRepository repository;

  VehicleUseCase(this.repository);

  Future<void> execute(VehicleModel vehicleEntity) async {
    return await repository.addVehicle(vehicleEntity);
  }

  Future<List<VehicleEntity>> fetchVehicles() async {
    return await repository.fetchVehicles();
  }
}
