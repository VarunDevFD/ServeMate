import 'package:serve_mate/features/product/doamin/entities/jewelry_entity.dart';

class JewelryModel extends JewelryEntity {
  JewelryModel({
    required String name,
    required double price,
    required double securityDeposit,
    required String location,
    required List<String> images,
    required String description,
    required String type,
    required String material,
    required String quantity,
    required String condition,
    required String brand,
    required String size,
    required String color,
    required String isAvailable,
    required String dateAdded,
  }) : super(
          name: name,
          price: price,
          securityDeposit: securityDeposit,
          location: location,
          images: images,
          description: description,
          type: type,
          material: material,
          quantity: quantity,
          condition: condition,
          brand: brand,
          size: size,
          color: color,
          isAvailable: isAvailable,
          dateAdded: dateAdded,
        );

  /// Converts the JewelryModel to a JSON map (useful for sending data to APIs or storing in a database)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'securityDeposit': securityDeposit,
      'location': location,
      'images': images,
      'description': description,
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
      price: json['price'].toDouble(),
      securityDeposit: json['securityDeposit'].toDouble(),
      location: json['location'],
      images: List<String>.from(json['images']), // Corrected to fetch 'images' from JSON
      description: json['description'],
      type: json['type'],
      material: json['material'],
      quantity: json['quantity'],
      condition: json['condition'],
      brand: json['brand'],
      size: json['size'],
      color: json['color'],
      isAvailable: json['isAvailable'],
      dateAdded: json['dateAdded'],
    );
  }
}
