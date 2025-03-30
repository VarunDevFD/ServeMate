import 'package:serve_mate/features/product/doamin/entities/jewelry.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class JewelryUseCase {
  final ProductRepository repository;

  JewelryUseCase(this.repository);

  Future<void> execute(Jewelry jewelry) async {
    return await repository.addJewelry(jewelry);
  }

  Future<List<Jewelry>> fetchJewelry() async {
    return await repository.fetchJewelry();
  }
}
