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

  Future<bool> _updateInFirestore<T>({
    required String collectionName,
    required String dId,
    required Map<String, dynamic> data,
    // required T Function(Map<String, dynamic>, String) fromMap,
  }) async {
    try {
      final userId = await currentUserId();
      final docRef = _firebaseFirestore.collection(collectionName).doc(dId);
      bool success = false;

      // Verify the document exists and belongs to the user
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        throw Exception('Document $dId does not exist in $collectionName');
      }
      final docData = docSnapshot.data() as Map<String, dynamic>;
      if (docData['userId'] != userId) {
        throw Exception(
            'User does not have permission to update this document');
      }

      // Update the document
      await docRef.update(data);
      success = true;
      return success;
    } catch (e) {
      throw Exception('Failed to update data in $collectionName: $e');
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

  @override
  Future<bool> updateCamera(
      String documentId, CameraModel updatedCamera) async {
    return await _updateInFirestore(
      collectionName: 'camera',
      dId: documentId,
      data: updatedCamera.toMap(),
      // fromMap: (data, docId) => CameraModel.fromMap(data, docId),
    );
  }

  @override
  Future<bool> updateDecoration(
      String documentId, DecorationModel updatedDecoration) async {
    return await _updateInFirestore(
      collectionName: 'Decoration',
      dId: documentId,
      data: updatedDecoration.toMap(),
      // fromMap: (data, docId) => DecorationModel.fromMap(data, docId),
    );
  }

  @override
  Future<bool> updateDress(String documentId, DressModel updatedDress) async {
    return await _updateInFirestore(
      collectionName: 'dress',
      dId: documentId,
      data: updatedDress.toMap(),
      // fromMap: (data, docId) => DressModel.fromMap(data, docId),
    );
  }

  @override
  Future<bool> updateFootwear(
      String documentId, FootwearModel updatedFootwear) async {
    return await _updateInFirestore(
      collectionName: 'footwear',
      dId: documentId,
      data: updatedFootwear.toMap(),
      // fromMap: (data, docId) => FootwearModel.fromMap(data, docId),
    );
  }

  @override
  Future<bool> updateJewelry(
      String documentId, JewelryModel updatedJewelry) async {
    return await _updateInFirestore(
      collectionName: 'jewelry',
      dId: documentId,
      data: updatedJewelry.toMap(),
      // fromMap: (data, docId) => JewelryModel.fromMap(data, docId),
    );
  }

  @override
  Future<bool> updateSound(String documentId, SoundModel updatedSound) async {
    return await _updateInFirestore(
      collectionName: 'sound',
      dId: documentId,
      data: updatedSound.toMap(),
      // fromMap: (data, docId) => SoundModel.fromMap(data, docId),
    );
  }

  @override
  Future<bool> updateVehicle(
      String documentId, VehicleModel updatedVehicle) async {
    return await _updateInFirestore(
      collectionName: 'Vehicles',
      dId: documentId,
      data: updatedVehicle.toMap(),
      // fromMap: (data, docId) => VehicleModel.fromMap(data, docId),
    );
  }

  @override
  Future<bool> updateVenue(String documentId, VenueModel updatedVenue) async {
    return await _updateInFirestore(
      collectionName: 'venues',
      dId: documentId,
      data: updatedVenue.toMap(),
      // fromMap: (data, docId) => VenueModel.fromMap(data, docId),
    );
  }
}
