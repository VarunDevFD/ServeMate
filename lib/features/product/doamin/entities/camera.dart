class Camera {
  final String name;
  final String brand;
  final String model;
  final String description;
  final String category;
  final int price;
  final int sdPrice;
  final bool available;
  final List<String> location;
  final String phoneNumber;
  final String condition;
  final List<String>? storage;
  final List<String>? connectivity;
  final String duration;
  final String latePolicy;
  final List<String> images;
  final bool privacyPolicy;

  Camera(
      {required this.name,
      required this.brand,
      required this.model,
      required this.category,
      required this.description,
      required this.price,
      required this.sdPrice,
      required this.available,
      required this.location,
      required this.phoneNumber,
      required this.condition,
      required this.storage,
      required this.connectivity,
      required this.duration,
      required this.latePolicy,
      required this.images,
      required this.privacyPolicy});

  Camera copyWith({
    String? name,
    String? model,
    String? brand,
    String? category,
    String? description,
    int? price,
    int? sdPrice,
    bool? available,
    List<String>? location,
    String? phoneNumber,
    String? condition,
    List<String>? storage,
    List<String>? connectivity,
    String? duration,
    String? latePolicy,
    List<String>? images,
    bool? privacyPolicy,
  }) {
    return Camera(
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      category: category ?? this.category,
      description: description ?? this.description,
      price: price ?? this.price,
      sdPrice: sdPrice ?? this.sdPrice,
      available: available ?? this.available,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      condition: condition ?? this.condition,
      storage: storage ?? this.storage,
      connectivity: connectivity ?? this.connectivity,
      duration: duration ?? this.duration,
      latePolicy: latePolicy ?? this.latePolicy,
      images: images ?? this.images,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }

  static Camera empty() {
    return Camera(
      name: '',
      brand: '',
      model: '',
      category: '',
      description: '',
      price: 0,
      sdPrice: 0,
      available: false,
      location: ['', '', ''],
      phoneNumber: '',
      condition: '',
      storage: [],
      connectivity: [],
      duration: '',
      latePolicy: '',
      images: [],
      privacyPolicy: false,
    );
  }
}
