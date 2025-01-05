import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class DressUseCase {
  final ProductRepository repository;

  DressUseCase(this.repository);

  Future<void> execute(DressEntity dress) async {
    await repository.addDress(dress);
  }

  // Fetch all dresses
  Future<List<DressEntity>> fetchDresses() async {
    return await repository.fetchDresses();
  }
}
