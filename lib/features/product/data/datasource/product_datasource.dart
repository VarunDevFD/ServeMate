import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/product/data/models/camera_model.dart';
import 'package:serve_mate/features/product/data/models/decoration_model.dart';
import 'package:serve_mate/features/product/data/models/dress_model.dart';
import 'package:serve_mate/features/product/data/models/footwear_model.dart';
import 'package:serve_mate/features/product/data/models/jewelry_model.dart';
import 'package:serve_mate/features/product/data/models/sound_model.dart';
import 'package:serve_mate/features/product/data/models/vehicle_model.dart';
import 'package:serve_mate/features/product/data/models/venues_model.dart';

abstract class ProductRemoteDataSource {
  Future<void> addCamera(CameraModel camera);
  Future<void> addDecoration(DecorationModel decoration);
  Future<void> addDress(DressModel dress);
  Future<void> addFootwear(FootwearModel footwear);
  Future<void> addJewelry(JewelryModel jewelry);
  Future<void> addSound(SoundModel sound);
  Future<void> addVehicle(VehicleModel vehicle);
  Future<void> addVenue(VenueModel venue);

  // Fetch methods
  Future<List<CameraModel>> fetchCameras();
  Future<List<DecorationModel>> fetchDecorations();
  Future<List<DressModel>> fetchDresses();
  Future<List<JewelryModel>> fetchJewelry();
  Future<List<SoundModel>> fetchSound();
  Future<List<VehicleModel>> fetchVehicles();
  Future<List<FootwearModel>> fetchFootwear();
  Future<List<VenueModel>> fetchVenues();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final _firebaseFirestore = serviceLocator<FirebaseFirestore>();

  // Function to add data to Firestore
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
  Future<void> addDress(DressModel dress) async {
    await _addToFirestore(
      collectionName: 'dress',
      model: dress,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addFootwear(FootwearModel footwear) async {
    await _addToFirestore(
      collectionName: 'footwear',
      model: footwear,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addJewelry(JewelryModel jewelry) async {
    await _addToFirestore(
      collectionName: 'jewelry',
      model: jewelry,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addSound(SoundModel sound) async {
    await _addToFirestore(
      collectionName: 'sound',
      model: sound,
      toMap: (model) => model.toMap(),
    );
  }


  @override
  Future<void> addVehicle(VehicleModel vehicle) async {
    await _addToFirestore(
      collectionName: 'Vehicles',
      model: vehicle,
      toMap: (model) => model.toMap(),
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

  // Function to fetch data from Firestore
  Future<List<T>> fetchFromFirestoore<T>({
    required String collectionName,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    try {
      final snapshot =
          await _firebaseFirestore.collection(collectionName).get();
      return snapshot.docs.map((doc) => fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to fetch data from $collectionName: $e');
    }
  }

  // Fetch methods for different collections
  @override
  Future<List<CameraModel>> fetchCameras() async {
    return await fetchFromFirestoore<CameraModel>(
      collectionName: 'camera',
      fromMap: (map) => CameraModel.fromMap(map),
    );
  }

  @override
  Future<List<DecorationModel>> fetchDecorations() async {
    return await fetchFromFirestoore<DecorationModel>(
      collectionName: 'decoration',
      fromMap: (map) => DecorationModel.fromMap(map),
    );
  }

  @override
  Future<List<DressModel>> fetchDresses() async {
    return await fetchFromFirestoore<DressModel>(
      collectionName: 'dresses',
      fromMap: (map) => DressModel.fromMap(map),
    );
  }

  @override
  Future<List<FootwearModel>> fetchFootwear() async {
    return await fetchFromFirestoore<FootwearModel>(
      collectionName: 'footwear',
      fromMap: (map) => FootwearModel.fromMap(map),
    );
  }

  @override
  Future<List<JewelryModel>> fetchJewelry() async {
    return await fetchFromFirestoore<JewelryModel>(
      collectionName: 'jewelry',
      fromMap: (map) => JewelryModel.fromMap(map),
    );
  }

  @override
  Future<List<SoundModel>> fetchSound() async {
    return await fetchFromFirestoore<SoundModel>(
      collectionName: 'sound',
      fromMap: (map) => SoundModel.fromMap(map),
    );
  }

  @override
  Future<List<VenueModel>> fetchVenues() async {
    return await fetchFromFirestoore<VenueModel>(
      collectionName: 'venues',
      fromMap: (map) => VenueModel.fromMap(map),
    );
  }

  @override
  Future<List<VehicleModel>> fetchVehicles() async {
    return await fetchFromFirestoore<VehicleModel>(
      collectionName: 'vehicle',
      fromMap: (map) => VehicleModel.fromMap(map),
    );
  }
}
