import 'package:serve_mate/features/product/data/models/rental_model.dart';

class VenueModel extends RentalItem {
  int? capacity;
  String? duration;
  double? rentalPrice;
  String? venueType;
  String? date;
  List<String>? facilities;
  List<String>? selectedFacilities;
  dynamic phone;
  String? email;

  // Constructor
  VenueModel({
    String? name,
    double? rentalPrice,
    double? securityDeposit,
    String? location,
    List<String>? images,
    String? description,
    this.capacity,
    this.duration,
    this.venueType,
    this.date,
    this.facilities,
    this.selectedFacilities,
    this.phone,
    this.email,
  }) : super(
          name: name,
          price: rentalPrice,
          securityDeposit: securityDeposit,
          location: location,
          images: images,
          description: description,
        );

  // Method to convert Venue object to a map (useful for database or API)
  factory VenueModel.fromMap(Map<String, dynamic> map) {
    return VenueModel(
      name: map['name'] as String?,
      location: map['location'] as String?,
      capacity: map['capacity'] as int?,
      duration: map['duration'] as String?,
      rentalPrice:
          map['price'] != null ? (map['price'] as num).toDouble() : null,
      securityDeposit:
          map['security'] != null ? (map['security'] as num).toDouble() : null,
      venueType: map['type'] as String?,
      date: map['date'] as String?,
      facilities: (map['facilities'] as List<String>?)?.cast<String>(),
      selectedFacilities:
          (map['selectedFacilities'] as List<String>?)?.cast<String>(),
      phone: map['phone'] as dynamic,
      email: map['email'] as String?,
      images: (map['images'] as List<dynamic>?)?.cast<String>(),
      description: map['description'] as String?,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'capacity': capacity,
      'duration': duration,
      'venueType': venueType,
      'date': date,
      'facilities': facilities,
      'selectedFacilities': selectedFacilities,
      'phone': phone,
      'email': email,
      'description': description,
    };
  }
}
