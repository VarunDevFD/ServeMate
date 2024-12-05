abstract class VenueFormEvent {}

class ToggleFacility extends VenueFormEvent {
  final String facility;

  ToggleFacility(this.facility);
}

class ToggleFacilitiesListExpansion extends VenueFormEvent {}
