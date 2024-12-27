import 'package:serve_mate/features/product/doamin/entities/footwear_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class AddFootwearUseCase {
  final ProductRepository repository;

  AddFootwearUseCase(this.repository);

  Future<void> call(FootwearEntity footwearEntity) async {
    return await repository.addFootwear(footwearEntity);
  }
}
