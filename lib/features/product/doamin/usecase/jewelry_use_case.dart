import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/product/doamin/entities/jewelry.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class JewelryUseCase {
  final repository = serviceLocator<ProductRepository>();


  Future<Either<String, String>> execute(Jewelry jewelry) async {
    return await repository.addJewelry(jewelry);
  }

 
}
