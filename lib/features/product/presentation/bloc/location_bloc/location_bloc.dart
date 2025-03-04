import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<FetchLocation>(_getLocation);
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
          accuracy: LocationAccuracy.high, // Set accuracy level
        ),
      );

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String address =
          "${placemarks.first.locality}, ${placemarks.first.country}";

      emit(LocationLoaded(address));
    } catch (e) {
      emit(LocationError("Failed to get location"));
    }
  }
}
