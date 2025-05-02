import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/utils/app_exception.dart';
import 'package:serve_mate/features/product/data/datasource/product_datasource.dart';
import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/core/models/decoration_model.dart';
import 'package:serve_mate/core/models/dress_model.dart';
import 'package:serve_mate/core/models/footwear_model.dart';
import 'package:serve_mate/core/models/jewelry_model.dart';
import 'package:serve_mate/core/models/sound_model.dart';
import 'package:serve_mate/core/models/vehicle_model.dart';
import 'package:serve_mate/core/models/venues_model.dart';
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
  final remoteDataSource = serviceLocator<ProductRemoteDataSource>();

  @override
  Future<Either<String, String>> addCamera(Camera camera) async {
    try {
      await remoteDataSource.addCamera(CameraModel.fromEntity(camera));
      return const Right("Success");
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      throw left('Failed to add camera: $e');
    }
  }

  @override
  Future<Either<String, String>> addDecorationEntity(
      DecorationEntity decoration) async {
    try {
      await remoteDataSource
          .addDecorationEntity(DecorationModel.fromEntity(decoration));
      return const Right("Success");
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      throw left('Failed to add decoration: $e');
    }
  }

  @override
  Future<Either<String, String>> addDress(Dress dress) async {
    try {
      await remoteDataSource.addDress(DressModel.fromEntity(dress));
      return const Right("Success");
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      throw left('Failed to add dress: $e');
    }
  }

  @override
  Future<Either<String, String>> addFootwear(Footwear footwear) async {
    try {
      await remoteDataSource.addFootwear(FootwearModel.fromEntity(footwear));
      return const Right("Success");
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      throw left('Failed to add footwear: $e');
    }
  }

  @override
  Future<Either<String, String>> addJewelry(Jewelry jewelry) async {
    try {
      await remoteDataSource.addJewelry(JewelryModel.fromEntity(jewelry));
      return const Right("Success");
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      throw left('Failed to add jewelry: $e');
    }
  }

  @override
  Future<Either<String, String>> addSound(Sound sound) async {
    try {
      await remoteDataSource.addSound(SoundModel.fromEntity(sound));
      return const Right("Success");
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      throw left('Failed to add sound: $e');
    }
  }

  @override
  Future<Either<String, String>> addVenue(Venue venue) async {
    try {
      await remoteDataSource.addVenue(VenueModel.fromEntity(venue));
      return const Right("Success");
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      throw left('Failed to add venue: $e');
    }
  }

  @override
  Future<Either<String, String>> addVehicle(Vehicle vehicle) async {
    try {
      await remoteDataSource.addVehicle(VehicleModel.fromEntity(vehicle));
      return const Right("Success");
    } on AppException catch (e) {
      return Left(e.alert);
    } catch (e) {
      throw left('Failed to add vehicle: $e');
    }
  }
}
