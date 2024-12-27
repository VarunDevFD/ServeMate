import 'package:serve_mate/features/product/doamin/entities/footwear_entity.dart';

class FootwearModel extends FootwearEntity {
  // Constructor to initialize FootwearModel, and call the parent constructor
  FootwearModel({
    required String name,
    required double? price,
    required double? securityDeposit,
    required String? location,
    required List<String>? images,
    required String? description,
    required String brand,
    required String condition,
    required String size,
    required String color,
    required String category,
    required String isAvailable,
    required String date,
  }) : super(
          name: name,
          price: price ?? 0.0,  // Default to 0.0 if null
          securityDeposit: securityDeposit ?? 0.0,  // Default to 0.0 if null
          location: location ?? '',  // Default to empty string if null
          images: images ?? [],  // Default to empty list if null
          description: description ?? '',
          brand: brand,
          condition: condition,
          size: size,
          color: color,
          category: category,
          isAvailable: isAvailable,
          date: date,
        );

  /// Converts the FootwearModel to a JSON map (useful for sending data to APIs or storing in a database)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'securityDeposit': securityDeposit,
      'location': location,
      'images': images,
      'description': description,
      'brand': brand,
      'condition': condition,
      'size': size,
      'color': color,
      'category': category,
      'isAvailable': isAvailable,
      'date': date,
    };
  }

  /// Factory constructor to create a FootwearModel object from a JSON map
  factory FootwearModel.fromJson(Map<String, dynamic> json) {
    return FootwearModel(
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      securityDeposit: (json['securityDeposit'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      brand: json['brand'] ?? '',
      condition: json['condition'] ?? '',
      size: json['size'] ?? '',
      color: json['color'] ?? '',
      category: json['category'] ?? '',
      isAvailable: json['isAvailable'] ?? '',
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      location: json['location'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
