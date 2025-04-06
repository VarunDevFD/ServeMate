class Venue {
  final String? name;
  final int? price;
  final int? sdPrice;
  final List<String>? location;
  final List<String>? images;
  final String? description;
  final int? capacity;
  final String? duration;
  final String? venueType;
  final String? phoneNumber;
  final String? date;
  final List<String>? facilities;
  final bool? available;
  final bool? privacyPolicy;

  Venue({
    this.name,
    this.price,
    this.sdPrice,
    this.location,
    this.images,
    this.description,
    this.capacity,
    this.duration,
    this.venueType,
    this.phoneNumber,
    this.date,
    this.facilities,
    this.available,
    this.privacyPolicy = false,
  });

  Venue copyWith({
    String? name,
    int? price,
    int? sdPrice,
    List<String>? location,
    List<String>? images,
    String? description,
    int? capacity,
    String? duration,
    String? venueType,
    String? phoneNumber,
    String? date,
    List<String>? facilities,
    List<String>? selectedFacilities,
    bool? available,
    bool? privacyPolicy,
  }) {
    return Venue(
      name: name ?? this.name,
      price: price ?? this.price,
      sdPrice: sdPrice ?? this.sdPrice,
      location: location ?? this.location,
      images: images ?? this.images,
      description: description ?? this.description,
      capacity: capacity ?? this.capacity,
      duration: duration ?? this.duration,
      venueType: venueType ?? this.venueType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      date: date ?? this.date,
      facilities: facilities ?? this.facilities,
      available: available ?? this.available,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }

  static empty() {
    return Venue(
      name: '',
      price: 0,
      sdPrice: 0,
      location: [],
      images: [],
      description: '',
      capacity: 0,
      duration: '',
      venueType: '',
      phoneNumber: '',
      date: '',
      facilities: [],
      available: false,
      privacyPolicy: false,
    );
  }
}
