import 'dart:developer';

import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class DressUseCase {
  final ProductRepository repository;

  DressUseCase(this.repository);

  Future<void> execute(Dress dress) async {
    log("DressUseCase: ${dress.name.toString()}");
    await repository.addDress(dress);
  }

  Future<List<Dress>> fetchDresses() async {
    return await repository.fetchDresses();
  }
}
