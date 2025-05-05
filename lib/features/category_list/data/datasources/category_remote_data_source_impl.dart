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

class H2CategoryRemoteDataSourceImpl implements H2CategoryRemoteDataSource {
  final _firebaseFirestore = serviceLocator<FirebaseFirestore>();
  final pref = serviceLocator<PreferencesRepository>();

  // Current user ID
  Future<String> currentUserId() {
    return pref.getUserId();
  }

  Future<List<T>> _fetchFromFirestore<T>({
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
  Future<List<CameraModel>> fetchCameras() async {
    return _fetchFromFirestore(
      collectionName: 'camera',
      fromMap: (data, docId) => CameraModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<DecorationModel>> fetchDecorations() async {
    return _fetchFromFirestore(
      collectionName: 'Decoration',
      fromMap: (data, docId) => DecorationModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<DressModel>> fetchDresses() async {
    return _fetchFromFirestore(
      collectionName: 'dress',
      fromMap: (data, docId) => DressModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<FootwearModel>> fetchFootwear() async {
    return _fetchFromFirestore(
      collectionName: 'footwear',
      fromMap: (data, docId) => FootwearModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<JewelryModel>> fetchJewelry() async {
    return _fetchFromFirestore(
      collectionName: 'jewelry',
      fromMap: (data, docId) => JewelryModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<SoundModel>> fetchSounds() async {
    return _fetchFromFirestore(
      collectionName: 'sound',
      fromMap: (data, docId) => SoundModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<VehicleModel>> fetchVehicles() async {
    return _fetchFromFirestore(
      collectionName: 'Vehicles',
      fromMap: (data, docId) => VehicleModel.fromMap(data, docId),
    );
  }

  @override
  Future<List<VenueModel>> fetchVenues() async {
    return _fetchFromFirestore(
      collectionName: 'venues',
      fromMap: (data, docId) => VenueModel.fromMap(data, docId),
    );
  }

  @override
  Future deleteCategory(String collectionName, String documentId) async {
    try {
      final userId = await currentUserId();
      // Reference to the specific document
      final docRef =
          _firebaseFirestore.collection(collectionName).doc(documentId);

      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        throw Exception(
            'Document $documentId does not exist in $collectionName');
      }

      final docData = docSnapshot.data() as Map<String, dynamic>;
      if (docData['userId'] != userId) {
        throw Exception(
            'User does not have permission to delete this document');
      }

      await docRef.delete();
    } catch (e) {
      throw Exception('Failed to delete document from $collectionName: $e');
    }
  }
}
