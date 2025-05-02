class Sound {
  final String? userId;
  final String? name;
  final String? category;
  final List<String>? equipmentTypes;
  final String? description;
  final int? price;
  final int? securityDeposit;
  final List<String>? location;
  final String? phoneNumber;
  final List<String>? images;
  final bool? available;
  final bool? privacyPolicy;
  final String? permission;

  Sound({
    this.userId,
    required this.name,
    required this.category,
    required this.equipmentTypes,
    required this.description,
    required this.price,
    required this.securityDeposit,
    required this.location,
    required this.phoneNumber,
    required this.images,
    required this.available,
    required this.privacyPolicy,
    required this.permission,
  });

  Sound copyWith({
    String? userId,
    String? name,
    String? category,
    List<String>? equipmentTypes,
    String? description,
    int? price,
    int? securityDeposit,
    List<String>? location,
    String? phoneNumber,
    List<String>? images,
    bool? available,
    bool? privacyPolicy,
    String? permission,
  }) {
    return Sound(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      category: category ?? this.category,
      equipmentTypes: equipmentTypes ?? this.equipmentTypes,
      description: description ?? this.description,
      price: price ?? this.price,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      images: images ?? this.images,
      available: available ?? this.available,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      permission: permission ?? this.permission,
    );
  }

  static empty() {
    return Sound(
      userId: '',
      name: '',
      category: '',
      equipmentTypes: [],
      description: '',
      price: 0,
      securityDeposit: 0,
      location: [],
      phoneNumber: '',
      images: [],
      available: false,
      privacyPolicy: false,
      permission: '',
    );
  }
}
