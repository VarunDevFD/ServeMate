import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/core/models/decoration_model.dart';
import 'package:serve_mate/core/models/dress_model.dart';
import 'package:serve_mate/core/models/footwear_model.dart';
import 'package:serve_mate/core/models/jewelry_model.dart';
import 'package:serve_mate/core/models/sound_model.dart';
import 'package:serve_mate/core/models/vehicle_model.dart';
import 'package:serve_mate/core/models/venues_model.dart';

abstract class DatasourceHome {
  Future<Map<String, bool>> getUserCategories({required String uid});
  Future<List<CameraModel>> homeFetchCameras();
  Future<List<DressModel>> homeFetchDresses();
  Future<List<DecorationModel>> homeFetchDecoration();
  Future<List<FootwearModel>> homeFetchFootwears();
  Future<List<JewelryModel>> homeFetchJewelrys();
  Future<List<SoundModel>> homeFetchSounds();
  Future<List<VehicleModel>> homeFetchVehicles();
  Future<List<VenueModel>> homeFetchVenues();
}
