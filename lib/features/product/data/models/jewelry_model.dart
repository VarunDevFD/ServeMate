class JewelryModel {
  final String? name;
  final String? type;
  final String? material;
  final double? price;
  final double? securityDeposit;
  final String? quantity;
  final String? condition;
  final String? brand;
  final String? size;
  final String? color;
  final String?
      isAvailable; // Represents the toggle (e.g., availability status)
  final String? description;
  final String? dateAdded;
  final String? location;
  final List<String>? images;

  JewelryModel({
    this.name,
    this.type,
    this.material,
    this.price,
    this.securityDeposit,
    this.quantity,
    this.condition,
    this.brand,
    this.size,
    this.color,
    this.isAvailable,
    this.description,
    this.dateAdded,
    this.location,
    this.images,
  });

  /// Converts the JewelryModel to a JSON map (useful for sending data to APIs or storing in a database)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'material': material,
      'price': price,
      'securityDeposit': securityDeposit,
      'quantity': quantity,
      'condition': condition,
      'brand': brand,
      'size': size,
      'color': color,
      'isAvailable': isAvailable,
      'description': description,
      'dateAdded': dateAdded,
      'location': location,
      'images': images,
    };
  }

  /// Factory constructor to create a JewelryModel object from a JSON map
  factory JewelryModel.fromJson(Map<String, dynamic> json) {
    return JewelryModel(
      name: json['name'],
      type: json['type'],
      material: json['material'],
      price: json['price'].toDouble(),
      securityDeposit: json['securityDeposit'].toDouble(),
      quantity: json['quantity'],
      condition: json['condition'],
      brand: json['brand'],
      size: json['size'],
      color: json['color'],
      isAvailable: json['isAvailable'],
      description: json['description'],
      dateAdded: json['dateAdded'],
      location: json['location'],
      images: List<String>.from(['imageUrls']),
    );
  }
}
