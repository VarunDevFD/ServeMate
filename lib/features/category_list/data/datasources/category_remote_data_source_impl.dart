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
import 'package:serve_mate/features/category_list/data/datasources/category_remote_data_source.dart';

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final _firebaseFirestore = serviceLocator<FirebaseFirestore>();
  final pref = serviceLocator<PreferencesRepository>();

  // Current user ID
  Future<String> currentUserId() {
    return pref.getUserId();
  }

  Future<List<T>> _fetchFromFirestore<T>({
    required String collectionName,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    try {
      final userId = await currentUserId();
      log("Keriii");
      log(userId);
      final snapshot = await _firebaseFirestore
          .collection(collectionName)
          .where('userId', isEqualTo: userId)
          .orderBy('time', descending: true) // Order by timestamp, newest first
          .get();
      log(snapshot.toString());
      log(snapshot.docs.toString());
      return snapshot.docs.map((doc) => fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to fetch data from $collectionName: $e');
    }
  }

  @override
  Future<List<CameraModel>> fetchCameras() async {
    return _fetchFromFirestore(
      collectionName: 'camera',
      fromMap: (data) => CameraModel.fromMap(data),
    );
  }

  @override
  Future<List<DecorationModel>> fetchDecorations() async {
    return _fetchFromFirestore(
      collectionName: 'Decoration',
      fromMap: (data) => DecorationModel.fromMap(data),
    );
  }

  @override
  Future<List<DressModel>> fetchDresses() async {
    return _fetchFromFirestore(
      collectionName: 'dress',
      fromMap: (data) => DressModel.fromMap(data),
    );
  }

  @override
  Future<List<FootwearModel>> fetchFootwear() async {
    return _fetchFromFirestore(
      collectionName: 'footwear',
      fromMap: (data) => FootwearModel.fromMap(data),
    );
  }

  @override
  Future<List<JewelryModel>> fetchJewelry() async {
    return _fetchFromFirestore(
      collectionName: 'jewelry',
      fromMap: (data) => JewelryModel.fromMap(data),
    );
  }

  @override
  Future<List<SoundModel>> fetchSounds() async {
    return _fetchFromFirestore(
      collectionName: 'sound',
      fromMap: (data) => SoundModel.fromMap(data),
    );
  }

  @override
  Future<List<VehicleModel>> fetchVehicles() async {
    return _fetchFromFirestore(
      collectionName: 'Vehicles',
      fromMap: (data) => VehicleModel.fromMap(data),
    );
  }

  @override
  Future<List<VenueModel>> fetchVenues() async {
    return _fetchFromFirestore(
      collectionName: 'venues',
      fromMap: (data) => VenueModel.fromMap(data),
    );
  }
}
