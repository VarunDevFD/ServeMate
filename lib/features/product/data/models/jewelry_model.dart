import 'package:serve_mate/features/product/doamin/entities/jewelry.dart';

class JewelryModel {
  final String? userId;
  final String? name;
  final String time = DateTime.now().toString();
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
  final bool? available;
  final String? phoneNumber;
  final bool? privacyPolicy;
  String? dateAdded = DateTime.now().toString();

  JewelryModel({
    this.userId,
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
    this.available,
    this.phoneNumber,
    this.privacyPolicy,
    this.dateAdded,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
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
      'available': available,
      'phoneNumber': phoneNumber,
      'privacyPolicy': privacyPolicy,
      'dateAdded': dateAdded,
    };
  }

  factory JewelryModel.fromMap(Map<String, dynamic> map) {
    return JewelryModel(
      userId: map['userId'],
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
      available: map['available'],
      phoneNumber: map['phoneNumber'],
      privacyPolicy: map['privacyPolicy'],
      dateAdded: map['dateAdded'],
    );
  }

  factory JewelryModel.fromEntity(Jewelry jewelry) {
    return JewelryModel(
      userId: jewelry.userId,
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
      available: jewelry.available,
      phoneNumber: jewelry.phoneNumber,
      privacyPolicy: jewelry.privacyPolicy,
      dateAdded: DateTime.now().toString(),
    );
  }

  Jewelry toEntity() {
    return Jewelry(
      userId: userId,
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
      available: available,
      phoneNumber: phoneNumber,
      privacyPolicy: privacyPolicy,
    );
  }

  JewelryModel copyWith({
    String? userId,
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
    bool? available,
    String? dateAdded,
    String? phoneNumber,
    bool? privacyPolicy,
  }) {
    return JewelryModel(
      userId: userId ?? this.userId,
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
      available: available ?? this.available,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }
}
