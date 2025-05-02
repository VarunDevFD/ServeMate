import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/product/doamin/entities/vehicle.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class VehicleUseCase {
  final repository = serviceLocator<ProductRepository>();

  Future<Either<String, String>> execute(Vehicle vehicle) async {
    return await repository.addVehicle(vehicle);
  }
}
