import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/category/data/models/category_model.dart';
import 'package:serve_mate/features/category/domain/entities/category_entities.dart';

abstract interface class CategoryRemoteDataSource {
  Future<List<Category>> fetchCategories();
  Future<void> saveCategory(
    CategoryModel dataModel,
    // String categoryName,
    // String imageUrl,
    // String userId,
  );
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final firestore = serviceLocator<FirebaseFirestore>();

  @override
  Future<List<Category>> fetchCategories() async {
    try {
      return [
        const Category(
            name: 'Cameras',
            imageUrl:
                'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/cameras.jpg',
            userId: null),
        const Category(
            name: 'Decoration',
            imageUrl:
                'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/decoration.jpg',
            userId: null),
        const Category(
            name: 'Dresses',
            imageUrl:
                'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/dresses.jpg',
            userId: null),
        const Category(
            name: 'FootWear',
            imageUrl:
                'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/footwear.jpg',
            userId: null),
        const Category(
            name: 'Jewelry',
            imageUrl:
                'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/jewelry.jpg',
            userId: null),
        const Category(
            name: 'Sound & DJ Systems',
            imageUrl:
                'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/sound&dj.jpg',
            userId: null),
        const Category(
            name: 'Vehicles',
            imageUrl:
                'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/vehicles.jpg',
            userId: null),
        const Category(
            name: 'Venue',
            imageUrl:
                'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/venues.jpg',
            userId: null),
      ];
    } catch (e) {
      log('Error fetching categories: $e');
      throw Exception('Failed to fetch categories $e');
    }
  }

  @override
  Future<void> saveCategory(
    CategoryModel dataModel,
    // String name,
    // String imageUrl,
    // String userId,
  ) async {
    final String? userDoc = await getUserUID();
    // await firestore
    //     .collection('users')
    //     .doc('serivceProviderFFPBly1VO1a1mUQfVnIWmcB2yoO2')
    //     .get();

    // if (!userDoc.exists) throw Exception('User not found');
    // final userId = userDoc.data()?['uid'];

    await firestore
        .collection('Categories')
        .doc('serivceProvider$userDoc')
        .set({'name': dataModel.name, 'userId': dataModel.userId});
  }

  Future<String?> getUserUID() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    log("Hellloooooooo");
    log(currentUser.toString());
    log("Baaaaaaai");

    if (currentUser != null) {
      return currentUser.uid; // Fetch UID
    } else {
      log("No user is logged in.");
      return null;
    }
  }
}




/*

// class CategoryRepositoryImpl implements CategoryRepository {

//   final firestore = serviceLocator<FirebaseFirestore>();

//   final List<Category> categories = [
//     Category(name: 'Cameras', imageUrl: 'assets/images/category/cameras.jpg'),
//     Category(
//         name: 'Decoration', imageUrl: 'assets/images/category/decoration.jpg'),
//     Category(name: 'Dresses', imageUrl: 'assets/images/category/dresses.jpg'),
//     Category(name: 'FootWear', imageUrl: 'assets/images/category/footwear.jpg'),
//     Category(name: 'Jewelry', imageUrl: 'assets/images/category/jewelry.jpg'),
//     Category(
//         name: 'Sound & DJ Systems',
//         imageUrl: 'assets/images/category/sound&dj.jpg'),
//     Category(name: 'Vehicles', imageUrl: 'assets/images/category/vehicles.jpg'),
//     Category(name: 'Venue', imageUrl: 'assets/images/category/venues.jpg'),
//   ];

//   @override
//   Future<List<Category>> getCategories() async {
//     // You could fetch this data from a local DB or API
//     return categories;
//   }

//   @override
//   void selectCategory(String categoryName) {
//     // Handle the logic for selecting the category
//     log('Selected category: $categoryName');
//   }

//    @override
//   Future<void> updateUserCategory({
//     required String userId,
//     required Category category,
//   }) async {
//     try {
//       // Update user's selected category in Firestore
//       await firestore.collection('users').doc(userId).update({
//         'category': category.name,
//       });
//       log('User category updated successfully: ${category.name}');
//     } catch (e) {
//       log('Error updating user category: $e');
//       throw Exception('Failed to update category');
//     }
//   }

// }

*/