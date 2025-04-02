class Venue {
  final String name;
  final int rentalPrice;
  final int securityDeposit;
  final List<String> location;
  final List<String> images;
  final String description;
  final int capacity;
  final String duration;
  final String venueType;
  final String phoneNumber;
  final String date;
  final List<String> facilities;
  final bool isAvailable;
  final bool privacyPolicy;

  Venue({
    required this.name,
    required this.rentalPrice,
    required this.securityDeposit,
    required this.location,
    required this.images,
    required this.description,
    required this.capacity,
    required this.duration,
    required this.venueType,
    required this.phoneNumber,
    required this.date,
    required this.facilities,
    required this.isAvailable,
    required this.privacyPolicy,
  });

  Venue copyWith({
    String? name,
    int? rentalPrice,
    int? securityDeposit,
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
    bool? isAvailable,
    bool? privacyPolicy,
  }) {
    return Venue(
      name: name ?? this.name,
      rentalPrice: rentalPrice ?? this.rentalPrice,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      location: location ?? this.location,
      images: images ?? this.images,
      description: description ?? this.description,
      capacity: capacity ?? this.capacity,
      duration: duration ?? this.duration,
      venueType: venueType ?? this.venueType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      date: date ?? this.date,
      facilities: facilities ?? this.facilities,
      isAvailable: isAvailable ?? this.isAvailable,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }

  static empty() {
    return Venue(
      name: '',
      rentalPrice: 0,
      securityDeposit: 0,
      location: [],
      images: [],
      description: '',
      capacity: 0,
      duration: '',
      venueType: '',
      phoneNumber: '',
      date: '',
      facilities: [],
      isAvailable: false,
      privacyPolicy: false,
    );
  }
}
