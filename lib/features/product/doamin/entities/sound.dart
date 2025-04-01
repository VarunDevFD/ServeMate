class Sound {
  final String? name;
  final String? category;
  final List<String> equipmentTypes;
  final String? description;
  final int? price;
  final int? securityDeposit;
  final List<String>? location;
  final String? phoneNumber;
  final List<String>? images;
  final bool? isAvailable;
  final bool? privacyPolicy;

  Sound( {
    required this.name,
    required this.category,
    required this.equipmentTypes,
    required this.description,
    required this.price,
    required this.securityDeposit,
    required this.location,
    required this.phoneNumber,
    required this.images,
    required this.isAvailable,
    required this.privacyPolicy,
  });

  Sound copyWith({
    String? name,
    String? category,
    List<String>? equipmentTypes,
    String? description,
    int? price,
    int? securityDeposit,
    List<String>? location,
    String? phoneNumber,
    List<String>? images,
    bool? isAvailable,
    bool? privacyPolicy,
  }) {
    return Sound(
      name: name ?? this.name,
      category: category ?? this.category,
      equipmentTypes: equipmentTypes ?? this.equipmentTypes,
      description: description ?? this.description,
      price: price ?? this.price,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      images: images ?? this.images,
      isAvailable: isAvailable ?? this.isAvailable,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }

  static empty() {
    return Sound(
      name: '',
      category: '',
      equipmentTypes: [],
      description: '',
      price: 0,
      securityDeposit: 0,
      location: [],
      phoneNumber: '',
      images: [],
      isAvailable: false,
      privacyPolicy: false,
    );
  }
}
