class Footwear {
  final String? userId;
  final String? name;
  final int? price;
  final int? sdPrice;
  final List<String>? location;
  final List<String>? images;
  final String? description;
  final String? brand;
  final String? condition;
  final List<String>? size;
  final String? color;
  final String? category;
  final bool? available;
  final String? date; 
  final String? time = DateTime.now().toString();
  final String? phoneNumber;
  final bool? privacyPolicy;
  

  Footwear({
    this.userId,
    required this.name,
    required this.price,
    required this.sdPrice,
    required this.location,
    required this.images,
    required this.description,
    required this.brand,
    required this.condition,
    required this.size,
    required this.color,
    required this.category,
    required this.available,
    required this.date, 
    required this.phoneNumber,
    required this.privacyPolicy,
  });

  Footwear copyWith({
    String? userId,
    String? name,
    int? price,
    int? sdPrice,
    List<String>? location,
    List<String>? images,
    String? description,
    String? brand,
    String? condition,
    List<String>? size,
    String? color,
    String? category,
    bool? available,
    String? date,
    String? time,
    String? phoneNumber,
    bool? privacyPolicy,
  }) {
    return Footwear(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      price: price ?? this.price,
      sdPrice: sdPrice ?? this.sdPrice,
      location: location ?? this.location,
      images: images ?? this.images,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      condition: condition ?? this.condition,
      size: size ?? this.size,
      color: color ?? this.color,
      category: category ?? this.category,
      available: available ?? this.available,
      date: date ?? this.date, 
      phoneNumber: phoneNumber ?? this.phoneNumber,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,

    );
  }

  static empty() {
    return Footwear(
      userId: '',
      name: '',
      price: 0,
      sdPrice: 0,
      location: [],
      images: [],
      description: '',
      brand: '',
      condition: '',
      size: [],
      color: '',
      category: '',
      available: false,
      date: '', 
      phoneNumber: '',
      privacyPolicy: false,
    );
  }
}
