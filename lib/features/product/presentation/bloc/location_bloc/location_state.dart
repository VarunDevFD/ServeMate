abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final List<String> location;

  LocationLoaded()
      : location = List.filled(3, ''); // Fixed-length list with 3 empty strings
}

class LocationError extends LocationState {
  final String message;
  LocationError(this.message);
}
