import 'dart:developer';

import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';
import 'package:serve_mate/features/category/domain/entities/category.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final List<Category> categories = [
    Category(name: 'Venues', imageUrl: 'assets/images/category/venues.jpg'),
    Category(name: 'Dresses', imageUrl: 'assets/images/category/dresses.jpg'),
    Category(name: 'Cameras', imageUrl: 'assets/images/category/cameras.jpg'),
    Category(name: 'Vehicles', imageUrl: 'assets/images/category/vehicles.jpg'),
    Category(name: 'Decoration', imageUrl: 'assets/images/category/decoration.jpg'),
    Category(name: 'Catering', imageUrl: 'assets/images/category/catering.jpg'),
    Category(name: 'Jewelry', imageUrl: 'assets/images/category/jewelry.jpg'),
    Category(name: 'Sound & DJ Systems', imageUrl: 'assets/images/category/sound&dj.jpg'),
    // Add other categories...
  ];

  @override
  Future<List<Category>> getCategories() async {
    // You could fetch this data from a local DB or API
    return categories;
  }

  @override
  void selectCategory(String categoryName) {
    // Handle the logic for selecting the category
    log('Selected category: $categoryName');
  }
}
