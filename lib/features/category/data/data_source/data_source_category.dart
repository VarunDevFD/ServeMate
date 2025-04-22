import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/utils/app_exception.dart';

abstract class DataSourceCategory {
  Future<void> updateCategoryName(String categoryName);
}

class DataSourceRemoteCategory implements DataSourceCategory {
  final firestore = serviceLocator<FirebaseFirestore>();
  final pref = serviceLocator<PreferencesRepository>();
  final role = 'ServiceProvider';

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
