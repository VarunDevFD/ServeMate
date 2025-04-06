class Jewelry {
  final String? name;
  final int? price;
  final int? securityDeposit;
  final List<String>? location;
  final List<String>? images;
  final String? description;
  final String? type;
  final String? material;
  final String? quantity;
  final String? condition;
  final String? brand;
  final String? size;
  final String? color;
  final bool? available;
  final String? dateAdded;

  Jewelry({
    required this.name,
    required this.price,
    required this.securityDeposit,
    required this.location,
    required this.images,
    required this.description,
    required this.type,
    required this.material,
    required this.quantity,
    required this.condition,
    required this.brand,
    required this.size,
    required this.color,
    required this.available,
    required this.dateAdded,
  });

  Jewelry copyWith({
    String? name,
    int? price,
    int? securityDeposit,
    List<String>? location,
    List<String>? images,
    String? description,
    String? type,
    String? material,
    String? quantity,
    String? condition,
    String? brand,
    String? size,
    String? color,
    bool? available,
    String? dateAdded,
  }) {
    return Jewelry(
      name: name ?? this.name,
      price: price ?? this.price,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      location: location ?? this.location,
      images: images ?? this.images,
      description: description ?? this.description,
      type: type ?? this.type,
      material: material ?? this.material,
      quantity: quantity ?? this.quantity,
      condition: condition ?? this.condition,
      brand: brand ?? this.brand,
      size: size ?? this.size,
      color: color ?? this.color,
      available: available ?? available,
      dateAdded: dateAdded ?? dateAdded,
    );
  }

  static empty() {
    return Jewelry(
      name: '',
      price: 0,
      securityDeposit: 0,
      location: [],
      images: [],
      description: '',
      type: '',
      material: '',
      quantity: '',
      condition: '',
      brand: '',
      size: '',
      color: '',
      available: false,
      dateAdded: '',
    );
  }
}
