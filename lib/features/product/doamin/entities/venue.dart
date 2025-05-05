class Venue {
  final String? id;
  final String? userId;
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
  final String? time = DateTime.now().toString();
  final List<String>? facilities;
  final bool? available;
  final bool? privacyPolicy;
  final String? permission;

  Venue({
    this.id,
    this.userId,
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
    this.facilities,
    this.available,
    this.privacyPolicy = false,
    this.permission,
  });

  Venue copyWith({
    String? id,
    String? userId,
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
    List<String>? facilities,
    List<String>? selectedFacilities,
    bool? available,
    bool? privacyPolicy,
    String? permission,
  }) {
    return Venue(
      id: id ?? this.id,
      userId: userId ?? this.userId,
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
      facilities: facilities ?? this.facilities,
      available: available ?? this.available,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      permission: permission ?? this.permission,
    );
  }

  static empty() {
    return Venue(
      id: '',
      userId: '',
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
      facilities: [],
      available: false,
      privacyPolicy: false,
      permission: '',
    );
  }
}
