class VenueEntity {
  final String name;
  final double rentalPrice;
  final double securityDeposit;
  final String location;
  final List<String> images;
  final String description;
  final int capacity;
  final String duration;
  final String venueType;
  final String date;
  final List<String> facilities;
  final List<String> selectedFacilities;

  VenueEntity({
    required this.name,
    required this.rentalPrice,
    required this.securityDeposit,
    required this.location,
    required this.images,
    required this.description,
    required this.capacity,
    required this.duration,
    required this.venueType,
    required this.date,
    required this.facilities,
    required this.selectedFacilities,
  });
}
