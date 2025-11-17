import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/utils/app_exception.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/images/app_images.dart';
import 'package:serve_mate/features/category/domain/entities/category_entities.dart';

abstract class DataSourceCategory {
  Future<List<Category>> fetchCategories();

  Future<void> updateCategoryName(String categoryName);
}

class DataSourceRemoteCategory implements DataSourceCategory {
  final FirebaseFirestore firestore;
  final PreferencesRepository pref;
  final role = 'ServiceProvider';

  DataSourceRemoteCategory({required this.firestore,required this.pref});

  @override
  Future<List<Category>> fetchCategories() async {
    try {
      return [
        const Category(
          name: Names.camera,
          imageUrl: VImages.cameraImg,
          userId: null,
        ),
        const Category(
          name: Names.decoration,
          imageUrl: VImages.decorationImg,
          userId: null,
        ),
        const Category(
          name: Names.dress,
          imageUrl: VImages.dressImg,
          userId: null,
        ),
        const Category(
          name: Names.footwear,
          imageUrl: VImages.footwearImg,
          userId: null,
        ),
        const Category(
          name: Names.jewelry,
          imageUrl: VImages.jewelryImg,
          userId: null,
        ),
        const Category(
          name: Names.sound,
          imageUrl: VImages.soundImg,
          userId: null,
        ),
        const Category(
          name: Names.vehicle,
          imageUrl: VImages.vehiclesImg,
          userId: null,
        ),
        const Category(
          name: Names.venue,
          imageUrl: VImages.venuesImg,
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
      // Category Field updated
      final userRef =
          firestore.collection('users').doc(role).collection(role).doc(uid);

      final doc = await userRef.get();

      if (!doc.exists) {
        throw Exception("User does not exist.");
      }

      List<dynamic> categories = doc.data()?['categories'] ?? [];

      /// Already exists
      if (categories.contains(categoryName)) {
        log("Category already exists. No update needed.");
        return;
      }

      /// Add category
      await userRef.update({
        'categoryName': categoryName,
        'categories': FieldValue.arrayUnion([categoryName]),
      });
    } catch (e) {
      throw AppException(
        details: 'Failed to update category: $e',
        alert: 'Failed to update category. Please try again.',
      );
    }
  }
}
