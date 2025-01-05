class LocationState {
  final String? currentLocation;
  final String? placeName;
  final String? locationError;
  final bool isFetchingLocation;

  const LocationState({
    this.currentLocation,
    this.placeName,
    this.locationError,
    this.isFetchingLocation = false,
  });

  LocationState copyWith({
    String? currentLocation,
    String? placeName,
    String? locationError,
    bool? isFetchingLocation,
  }) {
    return LocationState(
      currentLocation: currentLocation ?? this.currentLocation,
      placeName: placeName ?? this.placeName,
      locationError: locationError,
      isFetchingLocation: isFetchingLocation ?? this.isFetchingLocation,
    );
  }
}
