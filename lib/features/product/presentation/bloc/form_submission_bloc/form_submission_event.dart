import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/doamin/entities/decoration.dart';
import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/footwear.dart';
import 'package:serve_mate/features/product/doamin/entities/jewelry.dart';
import 'package:serve_mate/features/product/doamin/entities/sound.dart';
import 'package:serve_mate/features/product/doamin/entities/vehicle.dart';
import 'package:serve_mate/features/product/doamin/entities/venue.dart';

abstract class AddProductEvent {}

class CameraEvent extends AddProductEvent {
  final Camera camera;

  CameraEvent(this.camera);
}

class DecorationEvent extends AddProductEvent {
  final DecorationEntity decoration;
  DecorationEvent(this.decoration);
}

class DressEvent extends AddProductEvent {
  final Dress dress;
  DressEvent(this.dress);
}

class FootwearEvent extends AddProductEvent {
  final Footwear footwear;
  FootwearEvent(this.footwear);
}

class JewelryEvent extends AddProductEvent {
  final Jewelry jewelry;
  JewelryEvent(this.jewelry);
}

class SoundEvent extends AddProductEvent {
  final Sound sound;
  SoundEvent(this.sound);
}

class VehicleEvent extends AddProductEvent {
  final Vehicle vehicle;
  VehicleEvent(this.vehicle);
}

class VenueEvent extends AddProductEvent {
  final Venue venue;
  VenueEvent(this.venue);
}
