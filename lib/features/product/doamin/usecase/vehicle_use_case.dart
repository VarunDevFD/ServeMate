import 'package:serve_mate/features/product/doamin/entities/vehicle.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class VehicleUseCase {
  final ProductRepository repository;

  VehicleUseCase(this.repository);

  Future<void> execute(Vehicle vehicle) async {
    return await repository.addVehicle(vehicle);
  }

  Future<List<Vehicle>> fetchVehicles() async {
    return await repository.fetchVehicles();
  }
}
