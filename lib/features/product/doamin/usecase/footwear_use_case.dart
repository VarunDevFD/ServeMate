import 'package:serve_mate/features/product/doamin/entities/footwear.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class  FootwearUseCase {
  final ProductRepository repository;

  FootwearUseCase(this.repository);

  Future<void> execute(Footwear footwearEntity) async {
    return await repository.addFootwear(footwearEntity);
  }

  Future<List<Footwear>> fetchFootwear() async {
    return await repository.fetchFootwear();
  }
}
