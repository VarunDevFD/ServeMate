import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/utils/app_exception.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/features/category/domain/entities/category_entities.dart';

abstract class DataSourceCategory {
  Future<List<Category>> fetchCategories();

  Future<void> updateCategoryName(String categoryName);
}

class DataSourceRemoteCategory implements DataSourceCategory {
  final firestore = serviceLocator<FirebaseFirestore>();
  final pref = serviceLocator<PreferencesRepository>();
  final role = 'ServiceProvider';

  @override
  Future<List<Category>> fetchCategories() async {
    try {
      return [
        const Category(
          name: Names.camera,
          imageUrl:
              'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/cameras.jpg',
          userId: null,
        ),
        const Category(
          name: Names.decoration,
          imageUrl:
              'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/decoration.jpg',
          userId: null,
        ),
        const Category(
          name: Names.dress,
          imageUrl:
              'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/dresses.jpg',
          userId: null,
        ),
        const Category(
          name: Names.footwear,
          imageUrl:
              'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/footwear.jpg',
          userId: null,
        ),
        const Category(
          name: Names.jewelry,
          imageUrl:
              'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/jewelry.jpg',
          userId: null,
        ),
        const Category(
          name: Names.sound,
          imageUrl:
              'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/sound&dj.jpg',
          userId: null,
        ),
        const Category(
          name: Names.vehicle,
          imageUrl:
              'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/vehicles.jpg',
          userId: null,
        ),
        const Category(
          name: Names.venue,
          imageUrl:
              'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/venues.jpg',
          userId: null,
        ),
      ];
    } catch (e) {
      log('Error fetching categories: $e');
      throw Exception('Failed to fetch categories $e');
    }
  }

  @override
  Future<void> updateCategoryName(String categoryName) async {
    try {
      final uid = await pref.getUserId();
      if (role.isEmpty) {
        throw const AppException(
          details: 'Role is empty',
          alert: 'Failed to update category: Invalid role.',
        );
      }
      await pref.setCategoryName(categoryName);
      // Category Field updated on firebase
      await firestore
          .collection('users')
          .doc(role)
          .collection(role)
          .doc(uid)
          .update({
        'categoryName': categoryName,
      });
    } catch (e) {
      throw AppException(
        details: 'Failed to update category: $e',
        alert: 'Failed to update category. Please try again.',
      );
    }
  }
}
