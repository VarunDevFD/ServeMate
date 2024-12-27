import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class AddDressUseCase {
  final ProductRepository repository;

  AddDressUseCase(this.repository);

  Future<void> execute(DressEntity dress) async {
    await repository.addDress(dress);
  }
}
