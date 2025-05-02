import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/product/doamin/entities/footwear.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class  FootwearUseCase {
  final repository = serviceLocator<ProductRepository>();


  Future<Either<String, String>> execute(Footwear footwearEntity) async {
    return await repository.addFootwear(footwearEntity);
  }

  Future<List<Footwear>> fetchFootwear() async {
    return await repository.fetchFootwear();
  }
}
