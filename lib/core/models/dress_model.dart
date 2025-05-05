import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';

class DressModel {
  final String id;
  final String userId;
  final String name;
  final String time = DateTime.now().toString();
  final String gender;
  final String type;
  final String size;
  final String color;
  final String material;
  final String brand;
  final String duration;
  final int price;
  final int sdPrice;
  final String condition;
  final String date;
  final List<String> location;
  final String phoneNumber;
  final List<String> images;
  final bool available;
  final bool privacyPolicy;
  final String description;
  final String? permission;

  DressModel({
    this.id = '',
    required this.userId,
    required this.name,
    required this.gender,
    required this.type,
    required this.size,
    required this.color,
    required this.material,
    required this.brand,
    required this.duration,
    required this.price,
    required this.sdPrice,
    required this.condition,
    required this.date,
    required this.location,
    required this.phoneNumber,
    required this.images,
    required this.available,
    required this.privacyPolicy,
    required this.description,
    required this.permission,
  });

  DressModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? gender,
    String? type,
    String? size,
    String? color,
    String? material,
    String? brand,
    String? duration,
    int? price,
    int? sdPrice,
    String? condition,
    String? date,
    List<String>? location,
    String? phoneNumber,
    List<String>? images,
    bool? privacyPolicy,
    bool? available,
    String? description,
    String? permission,
  }) {
    return DressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      type: type ?? this.type,
      size: size ?? this.size,
      color: color ?? this.color,
      material: material ?? this.material,
      brand: brand ?? this.brand,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      sdPrice: sdPrice ?? this.sdPrice,
      condition: condition ?? this.condition,
      date: date ?? this.date,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      images: images ?? this.images,
      available: available ?? this.available,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      description: description ?? this.description,
      permission: permission ?? this.permission,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'gender': gender,
      'type': type,
      'size': size,
      'color': color,
      'material': material,
      'brand': brand,
      'duration': duration,
      'price': price,
      'sdPrice': sdPrice,
      'condition': condition,
      'date': date,
      'location': location,
      'phoneNumber': phoneNumber,
      'images': images,
      'available': available,
      'privacyPolicy': privacyPolicy,
      'description': description,
      'permission': permission,
    };
  }

  factory DressModel.fromMap(Map<String, dynamic> map, String docId) {
    return DressModel(
      id: docId,
      userId: map['userId'],
      name: map['name'],
      gender: map['gender'],
      type: map['type'],
      size: map['size'],
      color: map['color'],
      material: map['material'],
      brand: map['brand'],
      duration: map['duration'],
      price: map['price'],
      sdPrice: map['sdPrice'],
      condition: map['condition'],
      date: map['date'],
      location: map['location'],
      phoneNumber: map['phoneNumber'],
      images: map['images'],
      available: map['available'],
      privacyPolicy: map['privacyPolicy'],
      description: map['description'],
      permission: map['permission'],
    );
  }

  factory DressModel.fromEntity(Dress dress) {
    return DressModel(
      id: dress.id ?? '',
      userId: dress.userId ?? '',
      name: dress.name ?? '',
      gender: dress.gender ?? '',
      type: dress.type ?? '',
      size: dress.size ?? '',
      color: dress.color ?? '',
      material: dress.material ?? '',
      brand: dress.brand ?? '',
      duration: dress.duration ?? '',
      price: dress.price ?? 0,
      sdPrice: dress.sdPrice ?? 0,
      condition: dress.condition ?? '',
      date: dress.date ?? '',
      location: dress.location ?? [],
      phoneNumber: dress.phoneNumber ?? '',
      images: dress.images ?? [],
      available: dress.available ?? false,
      privacyPolicy: dress.privacyPolicy ?? false,
      description: dress.description ?? '',
      permission: dress.permission ?? '',
    );
  }

  Dress toEntity() {
    return Dress(
      id: id,
      userId: userId,
      name: name,
      gender: gender,
      type: type, 
      size: size,
      color: color,
      material: material,
      brand: brand,
      duration: duration,
      price: price,
      sdPrice: sdPrice,
      condition: condition,
      date: date,
      location: location,
      phoneNumber: phoneNumber,
      images: images,
      available: available,
      privacyPolicy: privacyPolicy,
      description: description,
      permission: permission,
    );
  }
}
