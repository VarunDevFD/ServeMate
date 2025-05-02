import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class DressUseCase {
  final repository = serviceLocator<ProductRepository>();

  Future<Either<String, String>> execute(Dress dress) async {
    log("DressUseCase: ${dress.name.toString()}");
    return await repository.addDress(dress);
  }

  Future<List<Dress>> fetchDresses() async {
    return await repository.fetchDresses();
  }
}
