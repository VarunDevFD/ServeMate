class VenueFormState {
  final List<String> selectedFacilities;
  final bool isFacilitiesExpanded;

  const VenueFormState({
    this.selectedFacilities = const [],
    this.isFacilitiesExpanded = false,
  });

  VenueFormState copyWith({
    List<String>? selectedFacilities,
    bool? isFacilitiesExpanded,
  }) {
    return VenueFormState(
      selectedFacilities: selectedFacilities ?? this.selectedFacilities,
      isFacilitiesExpanded: isFacilitiesExpanded ?? this.isFacilitiesExpanded,
    );
  }
}
