import 'package:serve_mate/features/product/doamin/entities/footwear.dart';

class FootwearModel {
  final String name;
  final int price;
  final int sdPrice;
  final List<String> location;
  final List<String> images;
  final String description;
  final String brand;
  final String condition;
  final String size;
  final String color;
  final String category;
  final bool available;
  final String date;
  FootwearModel({
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

  FootwearModel copyWith({
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
    return FootwearModel(
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'sdPrice': sdPrice,
      'location': location,
      'images': images,
      'description': description,
      'brand': brand,
      'condition': condition,
      'size': size,
      'color': color,
      'category': category,
      'available': available,
      'date': date,
    };
  }

  factory FootwearModel.fromMap(Map<String, dynamic> map) {
    return FootwearModel(
      name: map['name'] as String,
      price: map['price'] as int,
      sdPrice: map['sdPrice'] as int,
      location: List<String>.from(
          (map['location'] as List<dynamic>).map((x) => x as String)),
      images: List<String>.from(
          (map['images'] as List<dynamic>).map((x) => x as String)),
      description: map['description'] as String,
      brand: map['brand'] as String,
      condition: map['condition'] as String,
      size: map['size'] as String,
      color: map['color'] as String,
      category: map['category'] as String,
      available: map['available'] as bool,
      date: map['date'] as String,
    );
  }

  factory FootwearModel.fromEntity(Footwear footwear) {
    return FootwearModel(
      name: footwear.name ?? '',
      price: footwear.price ?? 0,
      sdPrice: footwear.sdPrice ?? 0,
      location: footwear.location ?? [''],
      images: footwear.images ?? [''],
      description: footwear.description ?? '',
      brand: footwear.brand ?? '',
      condition: footwear.condition ?? '',
      size: footwear.size ?? '',
      color: footwear.color ?? '',
      category: footwear.category ?? '',
      available: footwear.available ?? false,
      date: footwear.date ?? '',
    );
  }

  Footwear toEntity() {
    return Footwear(
      name: name,
      price: price,
      sdPrice: sdPrice,
      location: location,
      images: images,
      description: description,
      brand: brand,
      condition: condition,
      size: size,
      color: color,
      category: category,
      available: available,
      date: date,
    );
  }
}
