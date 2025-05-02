class Dress {
  final String? userId;
  final String? name;
  final String? gender;
  final String? type;
  final String? size;
  final String? color;
  final String? material;
  final String? brand;
  final String? duration;
  final int? price;
  final int? sdPrice;
  final String? condition;
  final String? date;
  final List<String>? location;
  final String? phoneNumber;
  final List<String>? images;
  final bool? available;
  final bool? privacyPolicy;
  final String? description;
  final String? permission;

  Dress({
    this.userId,
    required this.name,
    required this.gender,
    required this.type,
    required this.size,
    required this.color,
    required this.material,
    required this.brand,
    required this.duration,
    required this.price,
    required this.sdPrice,
    required this.condition,
    required this.date,
    required this.location,
    required this.phoneNumber,
    required this.images,
    required this.available,
    required this.privacyPolicy,
    required this.description,
    required this.permission,
  });

  Dress copyWith({
    String? userId,
    String? name,
    String? gender,
    String? type,
    String? model,
    String? size,
    String? color,
    String? material,
    String? brand,
    String? duration,
    int? price,
    int? sdPrice,
    String? condition,
    String? date,
    List<String>? location,
    String? phoneNumber,
    List<String>? images,
    bool? available,
    bool? privacyPolicy,
    String? description,
    String? permission,
  }) {
    return Dress(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      type: type ?? this.type,
      size: size ?? this.size,
      color: color ?? this.color,
      material: material ?? this.material,
      brand: brand ?? this.brand,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      sdPrice: sdPrice ?? this.sdPrice,
      condition: condition ?? this.condition,
      date: date ?? this.date,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      images: images ?? this.images,
      available: available ?? this.available,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      description: description ?? this.description,
      permission: permission ?? this.permission,
    );
  }

  static Dress empty() {
    return Dress(
      userId: '',
      name: '',
      gender: '',
      type: '',
      size: '',
      color: '',
      material: '',
      brand: '',
      duration: '',
      price: 0,
      sdPrice: 0,
      condition: '',
      date: '',
      location: [],
      phoneNumber: '',
      images: [],
      available: false,
      privacyPolicy: false,
      description: '',
      permission: '',
    );
  }
}
