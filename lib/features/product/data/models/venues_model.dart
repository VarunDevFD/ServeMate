class VenueModel {
  String? name;
  String? location;
  int? capacity;
  String? duration;
  double? rentalPrice;
  double? securityDeposit;
  String? venueType;
  String? date;
  List<String>? facilities;
  List<String>? selectedFacilities;
  dynamic phone;
  String? email;
  List<String>? images;
  String? description;

  // Constructor
  VenueModel({
    this.name,
    this.location,
    this.capacity,
    this.duration,
    this.rentalPrice,
    this.securityDeposit,
    this.venueType,
    this.date,
    this.facilities,
    this.selectedFacilities,
    this.phone,
    this.email,
    this.images,
    this.description,
  });

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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'capacity': capacity,
      'duration': duration,
      'rentalPrice': rentalPrice,
      'securityDeposit': securityDeposit,
      'venueType': venueType,
      'date': date,
      'facilities': facilities,
      'selectedFacilities': selectedFacilities,
      'phone': phone,
      'email': email,
      'images': images,
      'description': description,
    };
  }
}
