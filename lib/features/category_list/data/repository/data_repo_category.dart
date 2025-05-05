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
}
