import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/category/data/data_source/data_source_category.dart';
import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';
import 'package:serve_mate/features/category/domain/entities/category.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final remoteDataSource = serviceLocator<DataSourceCategory>();
  final List<Category> categories = [
    Category(name: 'Cameras', imageUrl: 'assets/images/category/cameras.jpg'),
    Category(
        name: 'Decoration', imageUrl: 'assets/images/category/decoration.jpg'),
    Category(name: 'Dresses', imageUrl: 'assets/images/category/dresses.jpg'),
    Category(name: 'FootWear', imageUrl: 'assets/images/category/footwear.jpg'),
    Category(name: 'Jewelry', imageUrl: 'assets/images/category/jewelry.jpg'),
    Category(
        name: 'Sound & DJ Systems',
        imageUrl: 'assets/images/category/sound&dj.jpg'),
    Category(name: 'Vehicles', imageUrl: 'assets/images/category/vehicles.jpg'),
    Category(name: 'Venue', imageUrl: 'assets/images/category/venues.jpg'),
  ];

  @override
  Future<List<Category>> getCategories() async {
    // You could fetch this data from a local DB or API
    return categories;
  }

  @override
  Future<void> selectCategory(String categoryName) async {
    return remoteDataSource.updateCategoryName(categoryName);
  }
}
 
 
