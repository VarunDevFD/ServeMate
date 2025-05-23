import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/camera_model.dart';

import 'package:serve_mate/core/models/decoration_model.dart';

import 'package:serve_mate/core/models/dress_model.dart';

import 'package:serve_mate/core/models/footwear_model.dart';

import 'package:serve_mate/core/models/jewelry_model.dart';

import 'package:serve_mate/core/models/sound_model.dart';

import 'package:serve_mate/core/models/vehicle_model.dart';

import 'package:serve_mate/core/models/venues_model.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/utils/constants.dart';

import 'datasource_home.dart';

class DatasourceHomeImpl implements DatasourceHome {
  final _firebaseFirestore = serviceLocator<FirebaseFirestore>();
  final pref = serviceLocator<PreferencesRepository>();

  // Current user ID
  Future<String> currentUserId() {
    return pref.getUserId();
  }

  @override
  Future<Map<String, bool>> getUserCategories({required String uid}) async {
    final categorylist = Names.categoryNamesList;

    try {
      Map<String, bool> getCategories = Names.categoryNamesMap;
      for (String category in categorylist) {
        final snapshot = await _firebaseFirestore.collection(category).get();
        // Default to false
        getCategories[category] = false;

        for (var doc in snapshot.docs) {
          if (doc.data()['userId'] == uid) {
            log("true");
            getCategories[category] = true;

            // Stop checking other docs in this category
            break;
          }
        }
      }

      log(getCategories.toString());

      return getCategories;
    } catch (e) {
      throw Exception('Failed to fetch user involved categorys: $e');
    }
  }

  Future<List<T>> _fetchDataFirestore<T>({
    required String collectionName,
    required T Function(Map<String, dynamic>, String) fromMap,
  }) async {
    try {
      final userId = await currentUserId();
      final snapshot = await _firebaseFirestore
          .collection(collectionName)
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) => fromMap(doc.data(), doc.id)).toList();
    } catch (e) {
      throw Exception('Failed to fetch data from $collectionName: $e');
    }
  }

  @override
  Future<List<CameraModel>> homeFetchCameras() {
    return _fetchDataFirestore(
      collectionName: 'camera',
      fromMap: (data, docId) => CameraModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<DecorationModel>> homeFetchDecoration() {
    return _fetchDataFirestore(
      collectionName: 'Decoration',
      fromMap: (data, docId) => DecorationModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<DressModel>> homeFetchDresses() {
    return _fetchDataFirestore(
      collectionName: 'dress',
      fromMap: (data, docId) => DressModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<FootwearModel>> homeFetchFootwears() {
    return _fetchDataFirestore(
      collectionName: 'footwear',
      fromMap: (data, docId) => FootwearModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<JewelryModel>> homeFetchJewelrys() {
    return _fetchDataFirestore(
      collectionName: 'jewelry',
      fromMap: (data, docId) => JewelryModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<SoundModel>> homeFetchSounds() {
    return _fetchDataFirestore(
      collectionName: 'sound',
      fromMap: (data, docId) => SoundModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<VehicleModel>> homeFetchVehicles() {
    return _fetchDataFirestore(
      collectionName: 'Vehicles',
      fromMap: (data, docId) => VehicleModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<VenueModel>> homeFetchVenues() {
    return _fetchDataFirestore(
      collectionName: 'venues',
      fromMap: (data, docId) => VenueModel.fromMap(data, docId),
    );
  }
}
