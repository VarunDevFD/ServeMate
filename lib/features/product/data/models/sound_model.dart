import 'package:serve_mate/features/product/doamin/entities/sound.dart';

class SoundModel {
  final String name;
  final String category;
  final List<String> equipmentTypes;
  final String description;
  final int price;
  final int securityDeposit;
  final List<String> location;
  final String phoneNumber;
  final List<String> images;
  final bool isAvailable;
  final bool privacyPolicy;

  SoundModel({
    required this.name,
    required this.category,
    required this.equipmentTypes,
    required this.description,
    required this.price,
    required this.securityDeposit,
    required this.location,
    required this.phoneNumber,
    required this.images,
    required this.isAvailable,
    required this.privacyPolicy,
  });

  SoundModel copyWith({
    String? name,
    String? category,
    List<String>? equipmentTypes,
    String? description,
    int? price,
    int? securityDeposit,
    List<String>? location,
    String? phoneNumber,
    List<String>? images,
    bool? isAvailable,
    bool? privacyPolicy,
  }) {
    return SoundModel(
      name: name ?? this.name,
      category: category ?? this.category,
      equipmentTypes: equipmentTypes ?? this.equipmentTypes,
      description: description ?? this.description,
      price: price ?? this.price,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      images: images ?? this.images,
      isAvailable: isAvailable ?? this.isAvailable,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'equipmentTypes': equipmentTypes,
      'description': description,
      'price': price,
      'securityDeposit': securityDeposit,
      'location': location,
      'phoneNumber': phoneNumber,
      'images': images,
      'isAvailable': isAvailable,
      'privacyPolicy': privacyPolicy,
    };
  }

  factory SoundModel.fromMap(Map<String, dynamic> map) {
    return SoundModel(
      name: map['name'] as String ?? '',
      category: map['category'] as String ?? '',
      equipmentTypes: List<String>.from(map['equipmentTypes'] ?? []),
      description: map['description'] ?? '',
      price: map['price'] ?? 0,
      securityDeposit: map['securityDeposit'] ?? 0,
      location: List<String>.from(map['location']) ?? [],
      phoneNumber: map['phoneNumber'] ?? '',
      images: List<String>.from(map['images']) ?? [],
      isAvailable: map['isAvailable'] ?? false,
      privacyPolicy: map['privacyPolicy'] ?? false,
    );
  }

  factory SoundModel.fromEntity(Sound sound) {
    return SoundModel(
      name: sound.name ?? '',
      category: sound.category ?? '',
      equipmentTypes: sound.equipmentTypes ?? [],
      description: sound.description ?? '',
      price: sound.price ?? 0,
      securityDeposit: sound.securityDeposit ?? 0,
      location: sound.location ?? [],
      phoneNumber: sound.phoneNumber ?? '',
      images: sound.images ?? [],
      isAvailable: sound.isAvailable ?? false,
      privacyPolicy: sound.privacyPolicy ?? false,
    );
  }

  Sound toEntity() {
    return Sound(
      name: name,
      category: category,
      equipmentTypes: equipmentTypes,
      description: description,
      price: price,
      securityDeposit: securityDeposit,
      location: location,
      phoneNumber: phoneNumber,
      images: images,
      isAvailable: isAvailable,
      privacyPolicy: privacyPolicy,
    );
  }
}
