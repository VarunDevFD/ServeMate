import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled. Please enable them to proceed.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied. Please allow location permissions.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied. Please enable them in app settings.';
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> getPlaceName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      return "${place.locality}, ${place.country}";
    } catch (e) {
      return "Unable to retrieve place name";
    }
  }

  LocationBloc() : super(const LocationState()) {
    on<FetchCurrentLocation>((event, emit) async {
      emit(state.copyWith(isFetchingLocation: true, locationError: null));
      try {
        Position position = await determinePosition();
        String placeName =
            await getPlaceName(position.latitude, position.longitude);

        emit(state.copyWith(
          currentLocation: "${position.latitude}, ${position.longitude}",
          placeName: placeName,
          isFetchingLocation: false,
          locationError: null,
        ));
      } catch (error) {
        emit(state.copyWith(
          locationError: error.toString(),
          isFetchingLocation: false,
        ));
      }
    });

    on<ClearLocationError>((event, emit) {
      emit(state.copyWith(locationError: null));
    });

    on<LocationValidationFailed>((event, emit) {
      emit(state.copyWith(locationError: event.error));
    });

    on<LocationValidationCleared>((event, emit) {
      emit(state.copyWith(locationError: null));
    });
  }
}
