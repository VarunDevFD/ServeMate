class DressModel {
  final String? gender;
  final String? type;
  final String? model;
  final String? size;
  final String? color;
  final String? material;
  final String? brand;
  final String? duration;
  final double? price;
  final double? security;
  final String? condition;
  final String? date;
  final String? location;
  final List<String>? images;
  final String? damage;
  final String? description;

  DressModel({
    this.gender,
    this.type,
    this.model,   
    this.size,
    this.color,
    this.material,
    this.brand,
    this.duration,
    this.price,
    this.security,
    this.condition,
    this.date,
    this.location,
    this.images,
    this.damage,
    this.description,
  });

  // Factory method to create a DressModel from a Map (useful for Firestore/JSON)
  factory DressModel.fromMap(Map<String, dynamic> map) {
    return DressModel(
      gender: map['gender'] as String?,
      type: map['type'] as String?,
      model: map['model'] as String?,
      size: map['size'] as String?,
      color: map['color'] as String?,
      material: map['material'] as String?,
      brand: map['brand'] as String?,
      duration: map['duration'] as String?,
      price: map['price'] != null ? (map['price'] as num).toDouble() : null,
      security: map['security'] != null ? (map['security'] as num).toDouble() : null,
      condition: map['condition'] as String?,
      date: map['date'] as String?,
      location: map['location'] as String?,
      images: (map['images'] as List<dynamic>?)?.cast<String>(),
      damage: map['damage'] as String?,
      description: map['description'] as String?,
    );
  }

  // Method to convert DressModel to a Map (useful for Firestore/JSON)
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
