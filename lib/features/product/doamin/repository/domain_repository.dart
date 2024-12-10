import 'package:serve_mate/features/product/data/models/dress_model.dart';

abstract class ProductRepo {
  Future<DressModel> getCategory();

}