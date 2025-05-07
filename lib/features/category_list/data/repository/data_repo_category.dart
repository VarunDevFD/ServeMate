import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/core/models/decoration_model.dart';
import 'package:serve_mate/core/models/dress_model.dart';
import 'package:serve_mate/core/models/footwear_model.dart';
import 'package:serve_mate/core/models/jewelry_model.dart';
import 'package:serve_mate/core/models/sound_model.dart';
import 'package:serve_mate/core/models/vehicle_model.dart';
import 'package:serve_mate/core/models/venues_model.dart';
import 'package:serve_mate/features/category_list/data/datasources/category_remote_data_source.dart';
import 'package:serve_mate/features/category_list/domain/repository/repo_category.dart';

class H2CategoryRepositoryImpl implements H2CategoryRepository {
  final H2CategoryRemoteDataSource _dataSource;

  H2CategoryRepositoryImpl(this._dataSource);

  @override
  Future<List<CameraModel>> getCameras() => _dataSource.fetchCameras();

  @override
  Future<List<DecorationModel>> getDecorations() =>
      _dataSource.fetchDecorations();

  @override
  Future<List<DressModel>> getDresses() => _dataSource.fetchDresses();

  @override
  Future<List<FootwearModel>> getFootwear() => _dataSource.fetchFootwear();

  @override
  Future<List<JewelryModel>> getJewelry() => _dataSource.fetchJewelry();

  @override
  Future<List<SoundModel>> getSounds() => _dataSource.fetchSounds();

  @override
  Future<List<VehicleModel>> getVehicles() => _dataSource.fetchVehicles();

  @override
  Future<List<VenueModel>> getVenues() => _dataSource.fetchVenues();

  @override
  Future<void> deleteDocument({
    required String collectionName,
    required String documentId,
  }) =>
      _dataSource.deleteCategory(collectionName, documentId);

  // Update Methods
  @override
  Future<void> updateCamera(String dId, CameraModel model) =>
      _dataSource.updateCamera(dId, model);

  @override
  Future<void> updateDecoration(String dId, DecorationModel model) =>
      _dataSource.updateDecoration(dId, model);

  @override
  Future<void> updateDress(String dId, DressModel model) =>
      _dataSource.updateDress(dId, model);

  @override
  Future<void> updateFootwear(String dId, FootwearModel model) =>
      _dataSource.updateFootwear(dId, model);

  @override
  Future<void> updateJewelry(String dId, JewelryModel model) =>
      _dataSource.updateJewelry(dId, model);

  @override
  Future<void> updateSound(String dId, SoundModel model) =>
      _dataSource.updateSound(dId, model);

  @override
  Future<void> updateVehicle(String dId, VehicleModel model) =>
      _dataSource.updateVehicle(dId, model);

  @override
  Future<void> updateVenue(String dId, VenueModel model) =>
      _dataSource.updateVenue(dId, model);
}
