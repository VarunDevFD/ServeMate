import 'package:serve_mate/features/product/doamin/entities/venue_entity.dart';

class VenueModel extends VenueEntity {
  VenueModel({
    required String name,
    required double rentalPrice,
    required double securityDeposit,
    required String location,
    required List<String> images,
    required String description,
    required int capacity,
    required String duration,
    required String venueType,
    required String date,
    required List<String> facilities,
    required List<String> selectedFacilities,
  }) : super(
          name: name,
          rentalPrice: rentalPrice,
          securityDeposit: securityDeposit,
          location: location,
          images: images,
          description: description,
          capacity: capacity,
          duration: duration,
          venueType: venueType,
          date: date,
          facilities: facilities,
          selectedFacilities: selectedFacilities,
        );

  /// Factory constructor to create a `VenueModel` object from a map
  factory VenueModel.fromMap(Map<String, dynamic> map) {
    return VenueModel(
      name: map['name'] ?? '',
      rentalPrice: (map['rentalPrice'] as num).toDouble(),
      securityDeposit: (map['securityDeposit'] as num).toDouble(),
      location: map['location'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      description: map['description'] ?? '',
      capacity: map['capacity'] ?? 0,
      duration: map['duration'] ?? '',
      venueType: map['venueType'] ?? '',
      date: map['date'] ?? '',
      facilities: List<String>.from(map['facilities'] ?? []),
      selectedFacilities: List<String>.from(map['selectedFacilities'] ?? []),
    );
  }

  /// Converts the `VenueModel` object to a map (useful for API or database storage)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rentalPrice': rentalPrice,
      'securityDeposit': securityDeposit,
      'location': location,
      'images': images,
      'description': description,
      'capacity': capacity,
      'duration': duration,
      'venueType': venueType,
      'date': date,
      'facilities': facilities,
      'selectedFacilities': selectedFacilities,
    };
  }
}
