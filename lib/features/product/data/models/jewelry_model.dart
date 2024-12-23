import 'package:serve_mate/features/product/data/models/rental_model.dart';

class JewelryModel extends RentalItem {
  final String? type;
  final String? material;

  final String? quantity;
  final String? condition;
  final String? brand;
  final String? size;
  final String? color;
  final String?
      isAvailable; // Represents the toggle (e.g., availability status)
  
  final String? dateAdded;

  JewelryModel({
    String? name,
    double? price,
    double? securityDeposit,
    String? location,
    List<String>? images,
    String? description,
    this.type,
    this.material,
    this.quantity,
    this.condition,
    this.brand,
    this.size,
    this.color,
    this.isAvailable,
   
    this.dateAdded,
  }) : super(
          name: name,
          price: price,
          securityDeposit: securityDeposit,
          location: location,
          images: images,
          description: description,
        );

  /// Converts the JewelryModel to a JSON map (useful for sending data to APIs or storing in a database)
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'material': material,
      'quantity': quantity,
      'condition': condition,
      'brand': brand,
      'size': size,
      'color': color,
      'isAvailable': isAvailable,
      'dateAdded': dateAdded,
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
