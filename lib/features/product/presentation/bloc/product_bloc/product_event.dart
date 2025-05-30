// lib/features/product/presentation/bloc/product_bloc/product_event.dart
import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/core/models/decoration_model.dart';
import 'package:serve_mate/core/models/dress_model.dart';
import 'package:serve_mate/core/models/footwear_model.dart';
import 'package:serve_mate/core/models/jewelry_model.dart';
import 'package:serve_mate/core/models/vehicle_model.dart';
import 'package:serve_mate/core/models/venues_model.dart';

abstract class ProductEvent {}

class SubmitDressEvent extends ProductEvent {
  final DressModel dress;

  SubmitDressEvent(this.dress);
}

class SubmitJewelryEvent extends ProductEvent {
  final JewelryModel jewelry;

  SubmitJewelryEvent(this.jewelry);
}

class SubmitVenueEvent extends ProductEvent {
  final VenueModel venue;

  SubmitVenueEvent(this.venue);
}

class SubmitVehicleEvent extends ProductEvent {
  final VehicleModel vehicle;

  SubmitVehicleEvent(this.vehicle);
}

class SubmitCameraEvent extends ProductEvent {
  final CameraModel camera;

  SubmitCameraEvent(this.camera);
}

class SubmitDecorationEvent extends ProductEvent {
  final DecorationModel decoration;

  SubmitDecorationEvent(this.decoration);
}
class SubmitFootwearEvent extends ProductEvent {
  final FootwearModel footwear;

  SubmitFootwearEvent(this.footwear);
}
