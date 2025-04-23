import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/profile/data/model/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<void> updateUser(UserModel data);
  Future<UserModel> getUserDetails(String userId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final firestore = serviceLocator<FirebaseFirestore>();

  @override
  Future<void> updateUser(UserModel data) async {
    await firestore.collection('users').doc(data.id).update(data.toJson());
  }

  @override
  Future<UserModel> getUserDetails(String userId) async {
    try {
      // Use the provided userId instead of fetching UID again, unless you specifically need the current user's UID
      final String? uid = await getUserUID();
      if (uid == null) {
        throw Exception('No authenticated user found');
      }

      // Use uid instead of userId if you want to fetch the current user's data
      final doc = await firestore.collection('users').doc(uid).get();
      if (!doc.exists) {
        throw Exception('User not found');
      }
      return UserModel.fromJson({'id': doc.id, ...doc.data()!});
    } catch (e) {
      throw Exception('Failed to fetch user details: $e');
    }
  }

  Future<String?> getUserUID() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    log(currentUser.toString());

    if (currentUser != null) {
      return currentUser.uid;
    } else {
      return null;
    }
  }
}
