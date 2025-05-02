import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<FetchLocation>(_getLocation);
    on<ResetLocationEvent>(_resetLocation);
  }

  Future<void> _getLocation(
      FetchLocation event, Emitter<LocationState> emit) async {
    try {
      emit(LocationLoading());

      // Request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationError("Location permission denied."));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationError(
            "Location permissions are permanently denied. Enable from settings."));
        return;
      }

      // Use new settings parameter
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best, // Set accuracy level
        ),
      );

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String address =
          "${placemarks.first.thoroughfare}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.postalCode}, ${placemarks.first.country}";

      List<String> location = List.filled(3, '');

      location[0] = address;
      location[1] = position.latitude.toString();
      location[2] = position.longitude.toString();

      emit(LocationLoaded(location));
    } catch (e) {
      emit(LocationError("Failed to get location"));
    }
  }

  Future<void> _resetLocation(
      ResetLocationEvent event, Emitter<LocationState> emit) async {
    emit(LocationInitial());
  }
}
