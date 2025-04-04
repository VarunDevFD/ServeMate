import 'package:serve_mate/features/product/data/datasource/product_datasource.dart';
import 'package:serve_mate/features/product/data/models/camera_model.dart';
import 'package:serve_mate/features/product/data/models/decoration_model.dart';
import 'package:serve_mate/features/product/data/models/dress_model.dart';
import 'package:serve_mate/features/product/data/models/footwear_model.dart';
import 'package:serve_mate/features/product/data/models/jewelry_model.dart';
import 'package:serve_mate/features/product/data/models/sound_model.dart';
import 'package:serve_mate/features/product/data/models/vehicle_model.dart';
import 'package:serve_mate/features/product/data/models/venues_model.dart';
import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/doamin/entities/decoration.dart';
import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/footwear.dart';
import 'package:serve_mate/features/product/doamin/entities/jewelry.dart';
import 'package:serve_mate/features/product/doamin/entities/sound.dart';
import 'package:serve_mate/features/product/doamin/entities/vehicle.dart';
import 'package:serve_mate/features/product/doamin/entities/venue.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addCamera(Camera camera) async {
    try {
      await remoteDataSource.addCamera(CameraModel.fromEntity(camera));
    } catch (e) {
      throw Exception('Failed to add camera: $e');
    }
  }

  @override
  Future<void> addDecoration(Decoration decoration) async {
    try {
      await remoteDataSource
          .addDecoration(DecorationModel.fromEntity(decoration));
    } catch (e) {
      throw Exception('Failed to add decoration: $e');
    }
  }

  @override
  Future<void> addDress(Dress dress) async {
    try {
      await remoteDataSource.addDress(DressModel.fromEntity(dress));
    } catch (e) {
      throw Exception('Failed to add dress: $e');
    }
  }

  @override
  Future<void> addFootwear(Footwear footwear) async {
    try {
      await remoteDataSource.addFootwear(FootwearModel.fromEntity(footwear));
    } catch (e) {
      throw Exception('Failed to add footwear: $e');
    }
  }

  @override
  Future<void> addJewelry(Jewelry jewelry) async {
    try {
      await remoteDataSource.addJewelry(JewelryModel.fromEntity(jewelry));
    } catch (e) {
      throw Exception('Failed to add jewelry: $e');
    }
  }

  @override
  Future<void> addSound(Sound sound) async {
    try {
      await remoteDataSource.addSound(SoundModel.fromEntity(sound));
    } catch (e) {
      throw Exception('Failed to add sound: $e');
    }
  }

  @override
  Future<void> addVenue(Venue venue) async {
    try {
      await remoteDataSource.addVenue(VenueModel.fromEntity(venue));
    } catch (e) {
      throw Exception('Failed to add venue: $e');
    }
  }

  @override
  Future<void> addVehicle(Vehicle vehicle) async {
    try {
      await remoteDataSource.addVehicle(VehicleModel.fromEntity(vehicle));
    } catch (e) {
      throw Exception('Failed to add vehicle: $e');
    }
  }

  // Fetch methods for each entity
  @override
  Future<List<Camera>> fetchCameras() async {
    try {
      final cameras = await remoteDataSource.fetchCameras();
      return cameras
          .map((camera) =>
              CameraModel.fromMap(camera as Map<String, dynamic>).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch cameras: $e');
    }
  }

  @override
  Future<List<Decoration>> fetchDecorations() async {
    try {
      final decorations = await remoteDataSource.fetchDecorations();
      return decorations
          .map((decorationModel) =>
              DecorationModel.fromMap(decorationModel as Map<String, dynamic>)
                  .toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch decorations: $e');
    }
  }

  @override
  Future<List<Dress>> fetchDresses() async {
    try {
      final dresses = await remoteDataSource.fetchDresses();
      return dresses
          .map((dressModel) =>
              DressModel.fromMap(dressModel as Map<String, dynamic>).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch dresses: $e');
    }
  }

  @override
  Future<List<Footwear>> fetchFootwear() async {
    try {
      final footwear = await remoteDataSource.fetchFootwear();
      return footwear
          .map((footwearModel) =>
              FootwearModel.fromMap(footwearModel as Map<String, dynamic>)
                  .toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch footwear: $e');
    }
  }

  @override
  Future<List<Jewelry>> fetchJewelry() async {
    try {
      final jewelry = await remoteDataSource.fetchJewelry();
      return jewelry
          .map((jewelryItem) =>
              JewelryModel.fromMap(jewelryItem as Map<String, dynamic>)
                  .toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch jewelry: $e');
    }
  }

  @override
  Future<List<Sound>> fetchSound() async {
    try {
      final soundModels = await remoteDataSource
          .fetchSound(); // Returns Future<List<SoundModel>>
      return soundModels.map((soundModel) => soundModel.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to fetch sound: $e');
    }
  }

  @override
  Future<List<Vehicle>> fetchVehicles() async {
    try {
      final vehicles = await remoteDataSource.fetchVehicles();
      return vehicles.map((vehicle) => vehicle.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to fetch vehicles: $e');
    }
  }

  @override
  Future<List<Venue>> fetchVenues() async {
    try {
      final venues = await remoteDataSource.fetchVenues();
      return venues.map((venue) => venue.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to fetch venues: $e');
    }
  }
}
