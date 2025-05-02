import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/doamin/entities/decoration.dart';
import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/footwear.dart';
import 'package:serve_mate/features/product/doamin/entities/jewelry.dart';
import 'package:serve_mate/features/product/doamin/entities/sound.dart';
import 'package:serve_mate/features/product/doamin/entities/vehicle.dart';
import 'package:serve_mate/features/product/doamin/entities/venue.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<String, String>> addCamera(Camera camera);
  Future<Either<String, String>> addDecorationEntity(
      DecorationEntity decoration);
  Future<Either<String, String>> addDress(Dress dress);
  Future<Either<String, String>> addJewelry(Jewelry jewelry);
  Future<Either<String, String>> addSound(Sound sound);
  Future<Either<String, String>> addVenue(Venue venue);
  Future<Either<String, String>> addVehicle(Vehicle vehicle);
  Future<Either<String, String>> addFootwear(Footwear footwear);
  
}
