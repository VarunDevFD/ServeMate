import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/core/models/decoration_model.dart';
import 'package:serve_mate/core/models/dress_model.dart';
import 'package:serve_mate/core/models/footwear_model.dart';
import 'package:serve_mate/core/models/jewelry_model.dart';
import 'package:serve_mate/core/models/sound_model.dart';
import 'package:serve_mate/core/models/vehicle_model.dart';
import 'package:serve_mate/core/models/venues_model.dart';

abstract class HomeCategoryRepository {
  Future<Map<String, bool>> getUserCategories({required String userId});
  Future<List<CameraModel>> getCameras();
  Future<List<DecorationModel>> getDecorations();
  Future<List<DressModel>> getDresses();
  Future<List<FootwearModel>> getFootwear();
  Future<List<JewelryModel>> getJewelry();
  Future<List<SoundModel>> getSounds();
  Future<List<VehicleModel>> getVehicles();
  Future<List<VenueModel>> getVenues();
}
