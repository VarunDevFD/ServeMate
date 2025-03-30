// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:serve_mate/features/product/doamin/entities/jewelry.dart';

class JewelryModel {
  final String? name;
  final int? price;
  final int? securityDeposit;
  final List<String>? location;
  final List<String>? images;
  final String? description;
  final String? type;
  final String? material;
  final String? quantity;
  final String? condition;
  final String? brand;
  final String? size;
  final String? color;
  final bool? isAvailable;
  final String? dateAdded;
  JewelryModel({
    this.name,
    this.price,
    this.securityDeposit,
    this.location,
    this.images,
    this.description,
    this.type,
    this.material,
    this.quantity,
    this.condition,
    this.brand,
    this.size,
    this.color,
    this.isAvailable,
    this.dateAdded,
  });

  Map<String, dynamic> toMap() {
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

  factory JewelryModel.fromMap(Map<String, dynamic> map) {
    return JewelryModel(
      name: map['name'],
      price: map['price'],
      securityDeposit: map['securityDeposit'].toDouble(),
      location: map['location'],
      images: List<String>.from(
          map['images']), // Corrected to fetch 'images' from map
      description: map['description'],
      type: map['type'],
      material: map['material'],
      quantity: map['quantity'],
      condition: map['condition'],
      brand: map['brand'],
      size: map['size'],
      color: map['color'],
      isAvailable: map['isAvailable'],
      dateAdded: map['dateAdded'],
    );
  }

  factory JewelryModel.fromEntity(Jewelry jewelry) {
    return JewelryModel(
      name: jewelry.name,
      price: jewelry.price,
      securityDeposit: jewelry.securityDeposit,
      location: jewelry.location,
      images: jewelry.images,
      description: jewelry.description,
      type: jewelry.type,
      material: jewelry.material,
      quantity: jewelry.quantity,
      condition: jewelry.condition,
      brand: jewelry.brand,
      size: jewelry.size,
      color: jewelry.color,
      isAvailable: jewelry.isAvailable,
      dateAdded: jewelry.dateAdded,
    );
  }

  Jewelry toEntity() {
    return Jewelry(
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
  }

  JewelryModel copyWith({
    String? name,
    int? price,
    int? securityDeposit,
    List<String>? location,
    List<String>? images,
    String? description,
    String? type,
    String? material,
    String? quantity,
    String? condition,
    String? brand,
    String? size,
    String? color,
    bool? isAvailable,
    String? dateAdded,
  }) {
    return JewelryModel(
      name: name ?? this.name,
      price: price ?? this.price,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      location: location ?? this.location,
      images: images ?? this.images,
      description: description ?? this.description,
      type: type ?? this.type,
      material: material ?? this.material,
      quantity: quantity ?? this.quantity,
      condition: condition ?? this.condition,
      brand: brand ?? this.brand,
      size: size ?? this.size,
      color: color ?? this.color,
      isAvailable: isAvailable ?? this.isAvailable,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }
}
