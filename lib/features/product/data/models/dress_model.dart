import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';

class DressModel extends DressEntity {
  DressModel({
    required String gender,
    required String type,
    required String model,
    required String size,
    required String color,
    required String material,
    required String brand,
    required String duration,
    required double price,
    required double security,
    required String condition,
    required String date,
    required String location,
    required List<String> images,
    required String damage,
    required String description,
  }) : super(
          gender: gender,
          type: type,
          model: model,
          size: size,
          color: color,
          material: material,
          brand: brand,
          duration: duration,
          price: price,
          security: security,
          condition: condition,
          date: date,
          location: location,
          images: images,
          damage: damage,
          description: description,
        );

// Convert a Map to DressModel
  factory DressModel.fromMap(Map<String, dynamic> map) {
    return DressModel(
      gender: map['gender'] ?? '',
      type: map['type'] ?? '',
      model: map['model'] ?? '',
      size: map['size'] ?? '',
      color: map['color'] ?? '',
      material: map['material'] ?? '',
      brand: map['brand'] ?? '',
      duration: map['duration'] ?? '',
      price: map['price'],
      security: map['security'] ?? '',
      condition: map['condition'] ?? '',
      date: map['date'] ?? '',
      location: map['location'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      damage: map['damage'] ?? '',
      description: map['description'] ?? '',
    );
  }

  // Convert DressModel to Map
  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'type': type,
      'model': model,
      'size': size,
      'color': color,
      'material': material,
      'brand': brand,
      'duration': duration,
      'price': price,
      'security': security,
      'condition': condition,
      'date': date,
      'location': location,
      'images': images,
      'damage': damage,
      'description': description,
    };
  }

  
}
