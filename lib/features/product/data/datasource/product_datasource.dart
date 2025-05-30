import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/core/models/decoration_model.dart';
import 'package:serve_mate/core/models/dress_model.dart';
import 'package:serve_mate/core/models/footwear_model.dart';
import 'package:serve_mate/core/models/jewelry_model.dart';
import 'package:serve_mate/core/models/sound_model.dart';
import 'package:serve_mate/core/models/vehicle_model.dart';
import 'package:serve_mate/core/models/venues_model.dart';

abstract class ProductRemoteDataSource {
  Future<void> addCamera(CameraModel camera);
  Future<void> addDecorationEntity(DecorationModel decoration);
  Future<void> addDress(DressModel dress);
  Future<void> addFootwear(FootwearModel footwear);
  Future<void> addJewelry(JewelryModel jewelry);
  Future<void> addSound(SoundModel sound);
  Future<void> addVehicle(VehicleModel vehicle);
  Future<void> addVenue(VenueModel venue);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final _firebaseFirestore = serviceLocator<FirebaseFirestore>();
  final pref = serviceLocator<PreferencesRepository>();

  // Current user ID
  Future<String> currentUserId() {
    return pref.getUserId();
  }

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
    // Get the current user ID and set it in the camera model
    final userId = await currentUserId();
    camera = camera.copyWith(
      userId: userId,
    );

    await _addToFirestore(
      collectionName: 'camera',
      model: camera,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addDecorationEntity(DecorationModel decoration) async {
    // Get the current user ID and set it in the DecorationEntity model
    final userId = await currentUserId();
    decoration = decoration.copyWith(
      userId: userId,
    );
    await _addToFirestore(
      collectionName: 'Decoration',
      model: decoration,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addDress(DressModel dress) async {
    // Get the current user ID and set it in the dress model
    final userId = await currentUserId();
    dress = dress.copyWith(
      userId: userId,
    );
    await _addToFirestore(
      collectionName: 'dress',
      model: dress,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addFootwear(FootwearModel footwear) async {
    // Get the current user ID and set it in the footwear model
    final userId = await currentUserId();
    footwear = footwear.copyWith(
      userId: userId,
    );
    await _addToFirestore(
      collectionName: 'footwear',
      model: footwear,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addJewelry(JewelryModel jewelry) async {
    // Get the current user ID and set it in the jewelry model
    final userId = await currentUserId();
    jewelry = jewelry.copyWith(
      userId: userId,
    );
    await _addToFirestore(
      collectionName: 'jewelry',
      model: jewelry,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addSound(SoundModel sound) async {
    // Get the current user ID and set it in the sound model
    final userId = await currentUserId();
    sound = sound.copyWith(
      userId: userId,
    );
    await _addToFirestore(
      collectionName: 'sound',
      model: sound,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addVehicle(VehicleModel vehicle) async {
    // Get the current user ID and set it in the vehicle model
    final userId = await currentUserId();
    vehicle = vehicle.copyWith(
      userId: userId,
    );
    await _addToFirestore(
      collectionName: 'Vehicles',
      model: vehicle,
      toMap: (model) => model.toMap(),
    );
  }

  @override
  Future<void> addVenue(VenueModel venue) async {
    // Get the current user ID and set it in the venue model
    final userId = await currentUserId();
    venue = venue.copyWith(
      userId: userId,
    );
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
}
