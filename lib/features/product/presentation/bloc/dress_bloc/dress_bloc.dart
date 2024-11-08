import 'package:bloc/bloc.dart';
// import 'package:geolocator/geolocator.dart';
import 'dress_event.dart';
import 'dress_state.dart';

class DressFormBloc extends Bloc<DressFormEvent, DressFormState> {
  // Declare the method before using it.
  // Future<Position> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     throw 'Location services are disabled.';
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       throw 'Location permissions are denied';
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are permanently denied
  //     throw 'Location permissions are permanently denied, we cannot request permissions.';
  //   }

  //   // Permissions granted, get current location
  //   return await Geolocator.getCurrentPosition();
  // }

  DressFormBloc() : super(DressFormState()) {
    // Gender selection logic
    on<GenderSelected>((event, emit) {
      emit(
        state.copyWith(selectedGender: event.gender),
      );
    });

    // Dress type change logic
    on<DressTypeChanged>((event, emit) {
      emit(
        state.copyWith(selectedDressType: event.dressType),
      );
    });

    // Condition change logic
    on<DressConditionChanged>((event, emit) {
      emit(
        state.copyWith(selectedCondition: event.condition),
      );
    });

    // Size change logic
    on<SizeChanged>((event, emit) {
      emit(
        state.copyWith(selectedSize: event.size),
      );
    });

    // Color change logic
    on<ColorChanged>((event, emit) {
      emit(
        state.copyWith(selectedColor: event.color, colorName: event.colorName),
      );
    });

    // Current Location
    // on<CurrentLocation>((event, emit) async {
    //   emit(state.copyWith(isFetchingLocation: true, locationError: null));

    //   try {
    //     Position position = await determinePosition(); // Call the function here
    //     String location = "${position.latitude}, ${position.longitude}";

    //     // Update state with fetched location
    //     emit(state.copyWith(
    //         currentLocation: location, isFetchingLocation: false));
    //   } catch (error) {
    //     // Handle any errors during location fetching
    //     emit(state.copyWith(
    //         locationError: error.toString(), isFetchingLocation: false));
    //   }
    // });
  }
}
