import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
    final documentSnapshot = await firestore
        .collection('Categories')
        .doc('9TWBuWmhOwD9fKKeOyVC')
        .get();

    final String userName = documentSnapshot.data()?['name'];
    log(userName);
  }

  @override
  Future<DressModel> getCategory() async {
    return DressModel();
  }
}
