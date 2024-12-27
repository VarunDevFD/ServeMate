import 'package:serve_mate/features/product/data/models/vehicle_model.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class AddVehicleUseCase {
  final ProductRepository repository;

  AddVehicleUseCase(this.repository);

  Future<void> execute(VehicleModel vehicleEntity) async {
    return await repository.addVehicle(vehicleEntity);
  }
}
