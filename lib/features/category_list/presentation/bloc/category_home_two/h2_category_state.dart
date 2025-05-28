import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/core/models/decoration_model.dart';
import 'package:serve_mate/core/models/dress_model.dart';
import 'package:serve_mate/core/models/footwear_model.dart';
import 'package:serve_mate/core/models/jewelry_model.dart';
import 'package:serve_mate/core/models/sound_model.dart';
import 'package:serve_mate/core/models/vehicle_model.dart';
import 'package:serve_mate/core/models/venues_model.dart';

abstract class H2CategoryState {}

class H2CategoryInitial extends H2CategoryState {}

class H2CategoryLoading extends H2CategoryState {}

class CameraCategoryLoaded extends H2CategoryState {
  final List<CameraModel> categories;
  final CameraModel? selectedItem;
  CameraCategoryLoaded(this.categories, {this.selectedItem});
}

class DecorationCategoryLoaded extends H2CategoryState {
  final List<DecorationModel> categories;
  final DecorationModel? selectedItem;

  DecorationCategoryLoaded(this.categories, {this.selectedItem});
}

class DressCategoryLoaded extends H2CategoryState {
  final List<DressModel> categories;
  final DressModel? selectedItem;

  DressCategoryLoaded(this.categories, {this.selectedItem});
}

class FootwearCategoryLoaded extends H2CategoryState {
  final List<FootwearModel> categories;
  final FootwearModel? selectedItem;

  FootwearCategoryLoaded(this.categories, {this.selectedItem});
}

class JewelryCategoryLoaded extends H2CategoryState {
  final List<JewelryModel> categories;
  final JewelryModel? selectedItem;

  JewelryCategoryLoaded(this.categories, {this.selectedItem});
}

class SoundCategoryLoaded extends H2CategoryState {
  final List<SoundModel> categories;
  final SoundModel? selectedItem;

  SoundCategoryLoaded(this.categories, {this.selectedItem});
}

class VehiclesCategoryLoaded extends H2CategoryState {
  final List<VehicleModel> categories;
  final VehicleModel? selectedItem;

  VehiclesCategoryLoaded(this.categories, {this.selectedItem});
}

class VenuesCategoryLoaded extends H2CategoryState {
  final List<VenueModel> categories;
  final VenueModel? selectedItem;

  VenuesCategoryLoaded(this.categories, {this.selectedItem});
}

class UpdateScreen extends H2CategoryState {
  final String? name;
  final dynamic item;

  UpdateScreen({this.name, this.item});
}

class H2CategoryUpdated extends H2CategoryState {}

class H2CategoryError extends H2CategoryState {
  final String message;

  H2CategoryError(this.message);
}

// ---------------- New Category Types ----------------
class LoadingState extends H2CategoryState {}

class DetailsState extends H2CategoryState {
  final String itemName;
  final dynamic itemValue;
  final bool fromMain;

  DetailsState(this.itemName, this.itemValue,{ this.fromMain = false});
}

class LoadedState extends H2CategoryState {
  final List<dynamic> items;
  final dynamic model;
  LoadedState(this.items, {this.model});
}

class ErrorState extends H2CategoryState {
  final String message;
  ErrorState(this.message);
}
