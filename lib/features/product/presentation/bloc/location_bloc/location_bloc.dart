import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  // Declare the method before using it.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('service: Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('permission: Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  // Fetch the place name using geocoding
  Future<String> getPlaceName(double latitude, double longitude) async {
    try {
      // Get the placemarks from coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0]; // Get the first place from the list
      return "${place.locality}, ${place.country}"; // Return the formatted place name
    } catch (e) {
      return "Unable to retrieve place name";
    }
  }

  LocationBloc() : super(LocationState()) {
    on<FetchCurrentLocation>((event, emit) async {
      emit(state.copyWith(isFetchingLocation: true, locationError: null));

      try {
        Position position = await determinePosition(); // Get position
        String location = "${position.latitude}, ${position.longitude}";
        log("Fetched Location: $location");

        // Get the place name
        String placeName = await getPlaceName(position.latitude, position.longitude);
        log("Place Name: $placeName");

        // Update the state with fetched location and place name
        emit(state.copyWith(
            currentLocation: location, placeName: placeName, isFetchingLocation: false));
      } catch (error) {
        log("Error Fetching Location: $error");
        emit(state.copyWith(locationError: error.toString(), isFetchingLocation: false));
      }
    });
  }
}
