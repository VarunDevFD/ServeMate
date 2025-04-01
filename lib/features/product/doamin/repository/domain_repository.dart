import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/doamin/entities/decoration.dart';
import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/footwear.dart';
import 'package:serve_mate/features/product/doamin/entities/jewelry.dart';
import 'package:serve_mate/features/product/doamin/entities/sound.dart';
import 'package:serve_mate/features/product/doamin/entities/vehicle_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/venue_entity.dart';

abstract class ProductRepository {
  Future<void> addCamera(Camera camera);
  Future<void> addDecoration(Decoration decoration);
  Future<void> addDress(Dress dress);
  Future<void> addJewelry(Jewelry jewelry);
  Future<void> addSound(Sound sound);
  Future<void> addVenue(VenueEntity venue);
  Future<void> addVehicle(VehicleEntity vehicle);
  Future<void> addFootwear(Footwear footwear);
  // Fetch methods for each entity
  Future<List<Camera>> fetchCameras();
  Future<List<Decoration>> fetchDecorations();
  Future<List<Dress>> fetchDresses();
  Future<List<Jewelry>> fetchJewelry();
  Future<List<Sound>> fetchSound();
  Future<List<VenueEntity>> fetchVenues();
  Future<List<VehicleEntity>> fetchVehicles();
  Future<List<Footwear>> fetchFootwear();
}
