import 'package:serve_mate/features/product/doamin/entities/decoration.dart';

class DecorationModel {
  final String id;
  final String userId;
  final String time = DateTime.now().toString();
  final String name;
  final List<String> decorCategory;
  final List<String> decorStyles;
  final String description;
  final int price;
  final int sdPrice;
  final bool available;
  final String duration;
  final List<String> location;
  final String phoneNumber;
  final List<String> images;
  final bool privacyPolicy;
  final String? permission;

  DecorationModel({
    required this.userId,
    required this.id,
    required this.name,
    required this.decorCategory,
    required this.decorStyles,
    required this.description,
    required this.price,
    required this.sdPrice,
    required this.available,
    required this.duration,
    required this.location,
    required this.phoneNumber,
    required this.images,
    required this.privacyPolicy,
   required this.permission,
  });

  DecorationModel copyWith({
    String? id,
    String? userId,
    String? time,
    String? name,
    List<String>? decorCategory,
    List<String>? decorStyles,
    String? description,
    int? price,
    int? sdPrice,
    bool? available,
    String? duration,
    List<String>? location,
    String? phoneNumber,
    List<String>? images,
    bool? privacyPolicy,
    String? permission,
  }) {
    return DecorationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      decorCategory: decorCategory ?? this.decorCategory,
      decorStyles: decorStyles ?? this.decorStyles,
      description: description ?? this.description,
      price: price ?? this.price,
      sdPrice: sdPrice ?? this.sdPrice,
      available: available ?? this.available,
      duration: duration ?? this.duration,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      images: images ?? this.images,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      permission: permission ?? this.permission,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'time': time,
      'decorCategory': decorCategory,
      'decorStyles': decorStyles,
      'description': description,
      'price': price,
      'sdPrice': sdPrice,
      'available': available,
      'duration': duration,
      'location': location,
      'phoneNumber': phoneNumber,
      'images': images,
      'privacyPolicy': privacyPolicy,
      'permission': permission,
    };
  }

  factory DecorationModel.fromMap(Map<String, dynamic> map, String docId) {
    return DecorationModel(
      id: docId,
      userId: map['userId'] ?? '',
      name: map['name'],
      decorCategory: List<String>.from(map['decorCategory']),
      decorStyles: List<String>.from(map['decorStyles']),
      description: map['description'],
      price: map['price'],
      sdPrice: map['sdPrice'],
      available: map['available'],
      duration: map['duration'],
      location: List<String>.from(map['location']),
      phoneNumber: map['phoneNumber'],
      images: List<String>.from(map['images']),
      privacyPolicy: map['privacyPolicy'],
      permission: map['permission'],
    );
  }

  factory DecorationModel.fromEntity(DecorationEntity entity) {
    return DecorationModel(
      id: entity.id ?? '',
      userId: entity.userId ?? '',
      name: entity.name ?? '',
      decorCategory: entity.decorCategory ?? [''],
      decorStyles: entity.decorStyles ?? [],
      description: entity.description ?? '',
      price: entity.price ?? 0,
      sdPrice: entity.sdPrice ?? 0,
      available: entity.available ?? false,
      duration: entity.duration ?? '',
      location: entity.location ?? [],
      phoneNumber: entity.phoneNumber ?? '',
      images: entity.images ?? [],
      privacyPolicy: entity.privacyPolicy ?? false,
      permission: entity.permission ?? '',
    );
  }

  DecorationEntity toEntity() {
    return DecorationEntity(
      id: id,
      userId: userId,
      time: time,
      name: name,
      decorCategory: decorCategory,
      decorStyles: decorStyles,
      description: description,
      price: price,
      sdPrice: sdPrice,
      available: available,
      duration: duration,
      location: location,
      phoneNumber: phoneNumber,
      images: images,
      privacyPolicy: privacyPolicy,
      permission: permission,
    );
  }
}
