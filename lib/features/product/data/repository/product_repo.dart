import 'package:serve_mate/features/product/data/datasource/product_datasource.dart';
import 'package:serve_mate/features/product/data/models/camera_model.dart';
import 'package:serve_mate/features/product/data/models/decoration_model.dart';
import 'package:serve_mate/features/product/data/models/dress_model.dart';
import 'package:serve_mate/features/product/data/models/footwear_model.dart';
import 'package:serve_mate/features/product/data/models/jewelry_model.dart';
import 'package:serve_mate/features/product/data/models/vehicle_model.dart';
import 'package:serve_mate/features/product/data/models/venues_model.dart';
import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/doamin/entities/decoration_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/footwear_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/jewelry_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/vehicle_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/venue_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addDress(DressEntity dress) async {
    try {
      await remoteDataSource.addDress(dress as DressModel);
    } catch (e) {
      throw Exception('Failed to add dress: $e');
    }
  }

  @override
  Future<void> addJewelry(JewelryEntity jewelry) async {
    try {
      await remoteDataSource.addJewelry(jewelry as JewelryModel);
    } catch (e) {
      throw Exception('Failed to add jewelry: $e');
    }
  }

  @override
  Future<void> addVenue(VenueEntity venue) async {
    try {
      await remoteDataSource.addVenue(venue as VenueModel);
    } catch (e) {
      throw Exception('Failed to add venue: $e');
    }
  }

  @override
  Future<void> addCamera(Camera camera) async {
    try {
      await remoteDataSource.addCamera(CameraModel.fromEntity(camera));
    } catch (e) {
      throw Exception('Failed to add camera: $e');
    }
  }

  @override
  Future<void> addVehicle(VehicleEntity vehicle) async {
    try {
      await remoteDataSource.addVehicle(vehicle as VehicleModel);
    } catch (e) {
      throw Exception('Failed to add vehicle: $e');
    }
  }

  @override
  Future<void> addFootwear(FootwearEntity footwear) async {
    try {
      await remoteDataSource.addFootwear(footwear as FootwearModel);
    } catch (e) {
      throw Exception('Failed to add footwear: $e');
    }
  }

  @override
  Future<void> addDecoration(DecorationEntity decoration) async {
    try {
      await remoteDataSource.addDecoration(decoration as DecorationModel);
    } catch (e) {
      throw Exception('Failed to add decoration: $e');
    }
  }

  // Fetch methods for each entity
  @override
  Future<List<DressModel>> fetchDresses() async {
    try {
      final dresses = await remoteDataSource.fetchDresses();
      return dresses
          .map((dress) => DressModel.fromMap(dress as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch dresses: $e');
    }
  }

  @override
  Future<List<JewelryModel>> fetchJewelry() async {
    try {
      final jewelry = await remoteDataSource.fetchJewelry();
      return jewelry
          .map((jewelryItem) =>
              JewelryModel.fromJson(jewelryItem as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch jewelry: $e');
    }
  }

  @override
  Future<List<VenueModel>> fetchVenues() async {
    try {
      final venues = await remoteDataSource.fetchVenues();
      return venues
          .map((venue) => VenueModel.fromMap(venue as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch venues: $e');
    }
  }

  // @override
  // Future<List<CameraModel>> fetchCameras() async {
  //   try {
  //     final cameras = await remoteDataSource.fetchCameras();
  //     return cameras
  //         .map((camera) => CameraModel.fromMap(camera as Map<String, dynamic>))
  //         .toList();
  //   } catch (e) {
  //     throw Exception('Failed to fetch cameras: $e');
  //   }
  // }

  @override
  Future<List<DecorationModel>> fetchDecorations() async {
    try {
      final decorations = await remoteDataSource.fetchDecorations();
      return decorations
          .map((decoration) =>
              DecorationModel.fromMap(decoration as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch decorations: $e');
    }
  }

  @override
  Future<List<VehicleModel>> fetchVehicles() async {
    try {
      final vehicles = await remoteDataSource.fetchVehicles();
      return vehicles
          .map((vehicle) =>
              VehicleModel.fromJson(vehicle as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch vehicles: $e');
    }
  }

  @override
  Future<List<FootwearModel>> fetchFootwear() async {
    try {
      final footwear = await remoteDataSource.fetchFootwear();
      return footwear
          .map((footwearItem) =>
              FootwearModel.fromJson(footwearItem as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch footwear: $e');
    }
  }
}
