import 'package:serve_mate/features/product/doamin/entities/camera_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/decoration_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/footwear_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/jewelry_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/vehicle_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/venue_entity.dart';

abstract class ProductRepository {
  Future<void> addDress(DressEntity dress);
  Future<void> addJewelry(JewelryEntity jewelry);
  Future<void> addVenue(VenueEntity venue);
  Future<void> addCamera(CameraEntity camera);
  Future<void> addVehicle(VehicleEntity vehicle);
  Future<void> addFootwear(FootwearEntity footwear);
  Future<void> addDecoration(DecorationEntity decoration);
}

