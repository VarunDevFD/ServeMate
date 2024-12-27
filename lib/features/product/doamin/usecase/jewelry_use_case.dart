import 'package:serve_mate/features/product/doamin/entities/jewelry_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class AddJewelryUseCase {
  final ProductRepository repository;

  AddJewelryUseCase(this.repository);

  Future<void> execute(JewelryEntity jewelry) async {
    return await repository.addJewelry(jewelry);
  }
}
