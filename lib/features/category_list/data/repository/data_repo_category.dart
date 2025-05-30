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
  Future<bool> updateCamera(String dId, CameraModel model) {
    return _dataSource.updateCamera(dId, model);
  }

  @override
  Future<bool> updateDecoration(String dId, DecorationModel model) {
    return _dataSource.updateDecoration(dId, model);
  }

  @override
  Future<bool> updateDress(String dId, DressModel model) {
    return _dataSource.updateDress(dId, model);
  }

  @override
  Future<bool> updateFootwear(String dId, FootwearModel model) {
    return _dataSource.updateFootwear(dId, model);
  }

  @override
  Future<bool> updateJewelry(String dId, JewelryModel model) {
    return _dataSource.updateJewelry(dId, model);
  }

  @override
  Future<bool> updateSound(String dId, SoundModel model) {
    return _dataSource.updateSound(dId, model);
  }

  @override
  Future<bool> updateVehicle(String dId, VehicleModel model) {
    return _dataSource.updateVehicle(dId, model);
  }

  @override
  Future<bool> updateVenue(String dId, VenueModel model) {
    return _dataSource.updateVenue(dId, model);
  }
}
