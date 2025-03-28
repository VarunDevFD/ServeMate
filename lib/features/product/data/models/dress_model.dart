import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';

class DressModel {
  final String name;
  final String gender;
  final String type;
  final String model;
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
  final String privacyPolicy;
  final String description;

  DressModel({
    required this.name,
    required this.gender,
    required this.type,
    required this.model,
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
    required this.privacyPolicy,
    required this.description,
  });

  DressModel copyWith({
    String? name,
    String? gender,
    String? type,
    String? model,
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
    String? privacyPolicy,
    String? description,
  }) {
    return DressModel(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      type: type ?? this.type,
      model: model ?? this.model,
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
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'type': type,
      'model': model,
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
      'privacyPolicy': privacyPolicy,
      'description': description,
    };
  }

  factory DressModel.fromMap(Map<String, dynamic> map) {
    return DressModel(
      name: map['name'],
      gender: map['gender'],
      type: map['type'],
      model: map['model'],
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
      privacyPolicy: map['privacyPolicy'],
      description: map['description'],
    );
  }

  factory DressModel.fromEntity(Dress dress) {
    return DressModel(
      name: dress.name ?? '',
      gender: dress.gender ?? '',
      type: dress.type ?? '',
      model: dress.model ?? '',
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
      privacyPolicy: dress.privacyPolicy ?? '',
      description: dress.description ?? '',
    );
  }

  Dress toEntity() {
    return Dress(
      name: name,
      gender: gender,
      type: type,
      model: model,
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
      privacyPolicy: privacyPolicy,
      description: description,
    );
  }
}
