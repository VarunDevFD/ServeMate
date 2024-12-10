import 'package:serve_mate/features/product/data/models/dress_model.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class ProductProductUsecase {
  final ProductRepo domainRepo;

  ProductProductUsecase(this.domainRepo);

  Future<DressModel> getDomainCategory() {
    return domainRepo.getCategory();
  }
}
