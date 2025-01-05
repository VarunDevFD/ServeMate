abstract class LocationEvent {}

class FetchCurrentLocation extends LocationEvent {}

class ClearLocationError extends LocationEvent {}

class LocationValidationFailed extends LocationEvent {
  final String error;

  LocationValidationFailed(this.error);
}

class LocationValidationCleared extends LocationEvent {}
