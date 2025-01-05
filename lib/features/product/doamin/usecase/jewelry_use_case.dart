import 'package:serve_mate/features/product/doamin/entities/jewelry_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class JewelryUseCase {
  final ProductRepository repository;

  JewelryUseCase(this.repository);

  Future<void> execute(JewelryEntity jewelry) async {
    return await repository.addJewelry(jewelry);
  }

  Future<List<JewelryEntity>> fetchJewelry() async {
    return await repository.fetchJewelry();
  }
}
