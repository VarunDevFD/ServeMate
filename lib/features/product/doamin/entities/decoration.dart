class Decoration {
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

  Decoration({
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
  Decoration copyWith({
    String? name,
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
    return Decoration(
      name: name ?? this.name,
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

  static Decoration empty() {
    return Decoration(
      name: '',
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
