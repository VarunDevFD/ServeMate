class LocationState {
  final String? currentLocation;
  final String? placeName;
  final bool isFetchingLocation;
  final String? locationError;

  LocationState({
    this.currentLocation,
    this.placeName = 'Current Place',
    this.isFetchingLocation = false,
    this.locationError,
  });

  LocationState copyWith({
    String? currentLocation,
    String? placeName,
    bool? isFetchingLocation,
    String? locationError,
  }) {
    return LocationState(
      currentLocation: currentLocation ?? this.currentLocation,
      placeName: placeName ?? this.placeName,
      isFetchingLocation: isFetchingLocation ?? this.isFetchingLocation,
      locationError: locationError ?? this.locationError,
    );
  }
}
