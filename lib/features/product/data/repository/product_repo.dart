import 'package:serve_mate/features/product/data/datasource/product_datasource.dart';
import 'package:serve_mate/features/product/data/models/dress_model.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class ProductRepoImpl extends ProductRepo {
  final ProductRemoteDatasource productData;

  ProductRepoImpl(this.productData);

  @override
  Future<DressModel> getCategory() {
    return productData.getCategory();
  }
  @override
  Future<void> selectCategoryName() {
    return productData.selectCategoryName();
  }
}
