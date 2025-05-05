import 'package:serve_mate/features/product/doamin/entities/footwear.dart';

class FootwearModel {
  final String? id;
  final String userId;
  final String name;
  final int price;
  final int sdPrice;
  final List<String> location;
  final List<String> images;
  final String description;
  final String brand;
  final String condition;
  final List<String> size;
  final String color;
  final String category;
  final bool available;
  final String date;
  final String time = DateTime.now().toString();
  final String? phoneNumber;
  final bool? privacyPolicy;
  final String? permission;

  FootwearModel({
    this.id,
    required this.userId,
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
    required this.phoneNumber,
    required this.privacyPolicy,  
    required this.permission,
  });

  FootwearModel copyWith({
    String? id,
    String? userId,
    String? name,
    int? price,
    int? sdPrice,
    List<String>? location,
    List<String>? images,
    String? description,
    String? brand,
    String? condition,
    List<String>? size,
    String? color,
    String? category,
    bool? available,
    String? date,
    String? time,
    String? phoneNumber,
    bool? privacyPolicy,
    String? permission,


  }) {
    return FootwearModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
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
      phoneNumber: phoneNumber ?? this.phoneNumber,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      permission: permission ?? this.permission,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
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
      'phoneNumber': phoneNumber,
      'privacyPolicy': privacyPolicy,
      'permission': permission,
    };
  }

  factory FootwearModel.fromMap(Map<String, dynamic> map, String docId) {
    return FootwearModel(
      id: docId,
      userId: map['userId'] as String,
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
      size: List<String>.from(
          (map['size'] as List<dynamic>).map((x) => x as String)),
      color: map['color'] as String,
      category: map['category'] as String,
      available: map['available'] as bool,
      date: map['date'] as String,
      phoneNumber: map['phoneNumber'] as String,
      privacyPolicy: map['privacyPolicy'] as bool,
      permission: map['permission'] as String,
    );
  }

  factory FootwearModel.fromEntity(Footwear footwear) {
    return FootwearModel(
      id: footwear.id ?? '',
      userId: footwear.userId ?? '',
      name: footwear.name ?? '',
      price: footwear.price ?? 0,
      sdPrice: footwear.sdPrice ?? 0,
      location: footwear.location ?? [''],
      images: footwear.images ?? [''],
      description: footwear.description ?? '',
      brand: footwear.brand ?? '',
      condition: footwear.condition ?? '',
      size: footwear.size ?? [],
      color: footwear.color ?? '',
      category: footwear.category ?? '',
      available: footwear.available ?? false,
      date: footwear.date ?? '',
      phoneNumber: footwear.phoneNumber ?? '',
      privacyPolicy: footwear.privacyPolicy ?? false,
      permission: footwear.permission ?? '',
    );
  }

  Footwear toEntity() {
    return Footwear(
      id: id,
      userId: userId,
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
      phoneNumber: phoneNumber,
      privacyPolicy: privacyPolicy,
      permission: permission,
    );
  }
}
