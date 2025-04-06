class Product {
  final String id;
  final String type; // "camera", "dress", "vehicle"
  final String name;
  final int? price;
  final int? securityDeposit;
  final String? description;
  final String? location;
  final List<String>? images;
  final bool available;
  final String? phoneNumber;
  final Map<String, dynamic> attributes; // Type-specific fields

  Product({
    this.id = '',
    required this.type,
    required this.name,
    this.price,
    this.securityDeposit,
    this.description,
    this.location,
    this.images,
    this.available = true,
    this.phoneNumber,
    Map<String, dynamic>? attributes,
  }) : attributes = attributes ?? {};

  factory Product.empty(String type) => Product(type: type, name: '');

  Product copyWith({
    String? id,
    String? type,
    String? name,
    int? price,
    int? securityDeposit,
    String? description,
    String? location,
    List<String>? images,
    bool? available,
    String? phoneNumber,
    Map<String, dynamic>? attributes,
  }) {
    return Product(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      price: price ?? this.price,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      description: description ?? this.description,
      location: location ?? this.location,
      images: images ?? this.images,
      available: available ?? this.available,
      phoneNumber: phoneNumber ?? phoneNumber,
      attributes: attributes ?? Map.from(this.attributes),
    );
  }
}
