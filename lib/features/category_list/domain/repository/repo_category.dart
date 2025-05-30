import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/core/models/decoration_model.dart';
import 'package:serve_mate/core/models/dress_model.dart';
import 'package:serve_mate/core/models/footwear_model.dart';
import 'package:serve_mate/core/models/jewelry_model.dart';
import 'package:serve_mate/core/models/sound_model.dart';
import 'package:serve_mate/core/models/vehicle_model.dart';
import 'package:serve_mate/core/models/venues_model.dart';

abstract class H2CategoryRepository {
  Future<List<CameraModel>> getCameras();
  Future<List<DecorationModel>> getDecorations();
  Future<List<DressModel>> getDresses();
  Future<List<FootwearModel>> getFootwear();
  Future<List<JewelryModel>> getJewelry();
  Future<List<SoundModel>> getSounds();
  Future<List<VehicleModel>> getVehicles();
  Future<List<VenueModel>> getVenues();
  Future<void> deleteDocument({
    required String collectionName,
    required String documentId,
  });
  // Update methods
  Future<bool> updateCamera(String dId, CameraModel model);
  Future<bool> updateDecoration(String dId, DecorationModel model);
  Future<bool> updateDress(String dId, DressModel model);
  Future<bool> updateFootwear(String dId, FootwearModel model);
  Future<bool> updateJewelry(String dId, JewelryModel model);
  Future<bool> updateSound(String dId, SoundModel model);
  Future<bool> updateVehicle(String dId, VehicleModel model);
  Future<bool> updateVenue(String dId, VenueModel model);
}
