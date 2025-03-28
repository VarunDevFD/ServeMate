class Dress {
  final String? name;
  final String? gender;
  final String? type;
  final String? model;
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
  final String? privacyPolicy;
  final String? description;

  Dress({
    required this.name,
    required this.gender,
    required this.type,
    required this.model,
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
    required this.privacyPolicy,
    required this.description,
  });

  Dress copyWith({
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
    String? privacyPolicy,
    String? description,
  }) {
    return Dress(
      name: name ?? this.name, 
      gender: gender ?? this.gender, 
      type: type ?? this.type,
      model: model ?? this.model,
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
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      description: description ?? this.description,
    );
  }

  static Dress empty() {
    return Dress(
      name: '',
      gender: '',
      type: '',
      model: '',
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
      privacyPolicy: '',
      description: '',
    );
  }
}
