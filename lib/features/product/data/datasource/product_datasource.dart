

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/product/data/models/camera_model.dart';
import 'package:serve_mate/features/product/data/models/decoration_model.dart';
import 'package:serve_mate/features/product/data/models/dress_model.dart';
import 'package:serve_mate/features/product/data/models/footwear_model.dart';
import 'package:serve_mate/features/product/data/models/jewelry_model.dart';
import 'package:serve_mate/features/product/data/models/vehicle_model.dart';
import 'package:serve_mate/features/product/data/models/venues_model.dart';

abstract class ProductRemoteDataSource {
  Future<void> addDress(DressModel dress);
  Future<void> addJewelry(JewelryModel jewelry);
  Future<void> addVenue(VenueModel venue);
  Future<void> addCamera(CameraModel camera);
  Future<void> addDecoration(DecorationModel decoration);
  Future<void> addVehicle(VehicleModel vehicle);
  Future<void> addFootwear(FootwearModel footwear);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final _firebaseFirestore = serviceLocator<FirebaseFirestore>();

  Future<void> _addToFirestore<T>({
    required String collectionName,
    required T model,
    required Map<String, dynamic> Function(T) toMap,
  }) async {
    try {
      await _firebaseFirestore.collection(collectionName).add(toMap(model));
    } catch (e) {
      throw Exception('Failed to add product to $collectionName: $e');
    }
  }

  @override
  Future<void> addDress(DressModel dress) async {
    await _addToFirestore(
      collectionName: 'dresses',
      model: dress,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addJewelry(JewelryModel jewelry) async {
    await _addToFirestore(
      collectionName: 'jewelry',
      model: jewelry,
      toMap: (model) => model.toJson(),
    );
  }

  @override
  Future<void> addVenue(VenueModel venue) async {
    await _addToFirestore(
      collectionName: 'venues',
      model: venue,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addCamera(CameraModel camera) async {
    await _addToFirestore(
      collectionName: 'camera',
      model: camera,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addDecoration(DecorationModel decoration) async {
    await _addToFirestore(
      collectionName: 'decoration',
      model: decoration,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addVehicle(VehicleModel vehicle) async {
    await _addToFirestore(
      collectionName: 'vehicle',
      model: vehicle,
      toMap: (model) => model.toJson(),
    );
    
  }

  @override
  Future<void> addFootwear(FootwearModel footwear) async {
    await _addToFirestore(
      collectionName: 'footwear',
      model: footwear,
      toMap: (model) => model.toJson(),
    );
  }
}
