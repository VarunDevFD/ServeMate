import 'package:serve_mate/features/product/data/datasource/product_datasource.dart';
import 'package:serve_mate/features/product/data/models/camera_model.dart';
import 'package:serve_mate/features/product/data/models/decoration_model.dart';
import 'package:serve_mate/features/product/data/models/dress_model.dart';
import 'package:serve_mate/features/product/data/models/footwear_model.dart';
import 'package:serve_mate/features/product/data/models/jewelry_model.dart';
import 'package:serve_mate/features/product/data/models/vehicle_model.dart';
import 'package:serve_mate/features/product/data/models/venues_model.dart';

class ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepository({required this.remoteDataSource});

  Future<void> addDress(DressModel dress) async {
    try {
      await remoteDataSource.addDress(dress);
    } catch (e) {
      throw Exception('Failed to add dress: $e');
    }
  }

  Future<void> addJewelry(JewelryModel jewelry) async {
    try {
      await remoteDataSource.addJewelry(jewelry);
    } catch (e) {
      throw Exception('Failed to add jewelry: $e');
    }
  }

  Future<void> addVenue(VenueModel venue) async {
    try {
      await remoteDataSource.addVenue(venue);
    } catch (e) {
      throw Exception('Failed to add venue: $e');
    }
  }

  Future<void> addCamera(CameraModel camera) async {
    try {
      await remoteDataSource.addCamera(camera);
    } catch (e) {
      throw Exception('Failed to add camera: $e');
    }
  }

  Future<void> addVehicle(VehicleModel vehicle) async {
    try {
      await remoteDataSource.addVehicle(vehicle);
    } catch (e) {
      throw Exception('Failed to add vehicle: $e');
    }
  }

  Future<void> addFootwear(FootwearModel footwear) async {
    try {
      await remoteDataSource.addFootwear(footwear);
    } catch (e) {
      throw Exception('Failed to add footwear: $e');
    }
  }

  Future<void> addDecoration(DecorationItem decoration) async {
    try {
      await remoteDataSource.addDecoration(decoration);
    } catch (e) {
      throw Exception('Failed to add decoration: $e');
    }
  }
}
