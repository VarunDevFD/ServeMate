import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/core/models/decoration_model.dart';
import 'package:serve_mate/core/models/dress_model.dart';
import 'package:serve_mate/core/models/footwear_model.dart';
import 'package:serve_mate/core/models/jewelry_model.dart';
import 'package:serve_mate/core/models/sound_model.dart';
import 'package:serve_mate/core/models/vehicle_model.dart';
import 'package:serve_mate/core/models/venues_model.dart';
import 'package:serve_mate/features/home/data/datasource/datasource_home.dart';
import 'package:serve_mate/features/home/domain/repository/domain_home_category_repository.dart';

class HomeDataCategoryRepo implements HomeCategoryRepository {
  final _dataSource = serviceLocator<DatasourceHome>();

  @override
  Future<Map<String, bool>> getUserCategories({required String userId}) =>
      _dataSource.getUserCategories(uid: userId);

  @override
  Future<List<CameraModel>> getCameras() => _dataSource.homeFetchCameras();

  @override
  Future<List<DecorationModel>> getDecorations() =>
      _dataSource.homeFetchDecoration();

  @override
  Future<List<DressModel>> getDresses() => _dataSource.homeFetchDresses();

  @override
  Future<List<FootwearModel>> getFootwear() => _dataSource.homeFetchFootwears();

  @override
  Future<List<JewelryModel>> getJewelry() => _dataSource.homeFetchJewelrys();

  @override
  Future<List<SoundModel>> getSounds() => _dataSource.homeFetchSounds();

  @override
  Future<List<VehicleModel>> getVehicles() => _dataSource.homeFetchVehicles();

  @override
  Future<List<VenueModel>> getVenues() => _dataSource.homeFetchVenues();
}
