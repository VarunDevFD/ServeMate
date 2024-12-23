import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_mate/features/product/data/models/dress_model.dart';

abstract interface class ProductRemoteDatasource {
  Future<void> selectCategoryName();
  Future<DressModel> getCategory();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDatasource {
  final FirebaseFirestore firestore;

  ProductRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> selectCategoryName() async {
    final String? userDoc = await getUserUID();

    final documentSnapshot = await firestore
        .collection('Categories')
        .doc('serivceProvider$userDoc')
        .get();

    final String userName = documentSnapshot.data()?['name'];
    log(userName);
  }

  Future<String?> getUserUID() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      return currentUser.uid; // Fetch UID
    } else {
      log("No user is logged in.");
      return null;
    }
  }

  @override
  Future<DressModel> getCategory() async {
    return DressModel();
  }
}
