class Camera {
  final String? id;
  final String? userId;
  final String? time;
  final String? name;
  final String? brand;
  final String? model;
  final String? description;
  final String? category;
  final int? price;
  final int? sdPrice;
  final bool? available;
  final List<String>? location;
  final String? phoneNumber;
  final String? condition;
  final List<String>? storage;
  final List<String>? connectivity;
  final String? duration;
  final String? latePolicy;
  final List<String>? images;
  final bool? privacyPolicy;
  final String? permission;

  Camera({
    this.id,
    this.userId,
    this.time,
    this.name,
    this.brand,
    this.model,
    this.category,
    this.description,
    this.price,
    this.sdPrice,
    this.available,
    this.location,
    this.phoneNumber,
    this.condition,
    this.storage,
    this.connectivity,
    this.duration,
    this.latePolicy,
    this.images,
    this.privacyPolicy,
    this.permission,
  });

  Camera copyWith({
    String? id,
    String? userId,
    String? time,
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
      id: id ?? this.id,
      userId: userId ?? this.userId,
      time: time ?? this.time,
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
      id: '',
      userId: '',
      time: '',
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
