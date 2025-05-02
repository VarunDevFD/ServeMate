class DecorationEntity {
  final String? userId;
  final String? time;
  final String? name;
  final List<String>? decorCategory;
  final List<String>? decorStyles;
  final String? description;
  final int? price;
  final int? sdPrice;
  final bool? available;
  final String? duration;
  final List<String>? location;
  final String? phoneNumber;
  final List<String>? images;
  final bool? privacyPolicy;

  DecorationEntity({
    this.userId,
    this.time,
    this.name,
    this.decorCategory,
    this.decorStyles,
    this.description,
    this.price,
    this.sdPrice,
    this.available,
    this.duration,
    this.location,
    this.phoneNumber,
    this.images,
    this.privacyPolicy,
  });
  DecorationEntity copyWith({
    String? name,
    String? time,
    List<String>? decorCategory,
    List<String>? decorStyles,
    String? description,
    int? price,
    int? sdPrice,
    bool? available,
    String? duration,
    List<String>? location,
    String? phoneNumber,
    List<String>? images,
    bool? privacyPolicy,
  }) {
    return DecorationEntity(
      userId: userId,
      name: name ?? this.name,
      time: time ?? this.time,
      decorCategory: decorCategory ?? this.decorCategory,
      decorStyles: decorStyles ?? this.decorStyles,
      description: description ?? this.description,
      price: price ?? this.price,
      sdPrice: sdPrice ?? this.sdPrice,
      available: available ?? this.available,
      duration: duration ?? this.duration,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      images: images ?? this.images,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }

  static DecorationEntity empty() {
    return DecorationEntity(
      userId: '',
      name: '',
      time: '',
      decorCategory: [''],
      decorStyles: [],
      description: '',
      price: 0,
      sdPrice: 0,
      available: false,
      duration: '',
      location: [],
      phoneNumber: '',
      images: [],
      privacyPolicy: false,
    );
  }
}
