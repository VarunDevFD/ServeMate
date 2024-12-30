import 'package:serve_mate/features/product/data/datasource/product_datasource.dart';
import 'package:serve_mate/features/product/data/models/camera_model.dart';
import 'package:serve_mate/features/product/data/models/decoration_model.dart';
import 'package:serve_mate/features/product/data/models/dress_model.dart';
import 'package:serve_mate/features/product/data/models/footwear_model.dart';
import 'package:serve_mate/features/product/data/models/jewelry_model.dart';
import 'package:serve_mate/features/product/data/models/vehicle_model.dart';
import 'package:serve_mate/features/product/data/models/venues_model.dart';
import 'package:serve_mate/features/product/doamin/entities/camera_entity.dart';
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
  Future<void> addCamera(CameraEntity camera) async {
    try {
      await remoteDataSource.addCamera(camera as CameraModel);
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
}
