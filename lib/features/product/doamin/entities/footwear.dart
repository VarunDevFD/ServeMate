class Footwear {
  final String? name;
  final int? price;
  final int? sdPrice;
  final List<String>? location;
  final List<String>? images;
  final String? description;
  final String? brand;
  final String? condition;
  final String? size;
  final String? color;
  final String? category;
  final bool? available;
  final String? date;

  Footwear({
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
  });

  Footwear copyWith({
    String? name,
    int? price,
    int? sdPrice,
    List<String>? location,
    List<String>? images,
    String? description,
    String? brand,
    String? condition,
    String? size,
    String? color,
    String? category,
    bool? available,
    String? date,
  }) {
    return Footwear(
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
    );
  }

  static empty() {
    return Footwear(
      name: '',
      price: 0,
      sdPrice: 0,
      location: [],
      images: [],
      description: '',
      brand: '',
      condition: '',
      size: '',
      color: '',
      category: '',
      available: false,
      date: '',
    );
  }
}
