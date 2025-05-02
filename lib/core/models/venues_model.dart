import 'package:serve_mate/features/product/doamin/entities/venue.dart';

class VenueModel {
  final String userId;
  final String name;
  final String time = DateTime.now().toString();
  final int price;
  final int sdPrice;
  final List<String> location;
  final List<String> images;
  final String description;
  final int capacity;
  final String duration;
  final String venueType;
  final String phoneNumber;
  final List<String> facilities;
  final bool available;
  final bool privacyPolicy;

  VenueModel({
    required this.userId,
    required this.name,
    required this.price,
    required this.sdPrice,
    required this.location,
    required this.images,
    required this.description,
    required this.capacity,
    required this.duration,
    required this.venueType,
    required this.phoneNumber,
    required this.facilities,
    required this.available,
    required this.privacyPolicy,
  });

  // copyWith method
  VenueModel copyWith({
    String? userId,
    String? name,
    int? price,
    int? sdPrice,
    List<String>? location,
    List<String>? images,
    String? description,
    int? capacity,
    String? duration,
    String? venueType,
    String? phoneNumber,
    String? time,
    List<String>? facilities,
    bool? available,
    bool? privacyPolicy,
  }) {
    return VenueModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      price: price ?? this.price,
      sdPrice: sdPrice ?? this.sdPrice,
      location: location ?? this.location,
      images: images ?? this.images,
      description: description ?? this.description,
      capacity: capacity ?? this.capacity,
      duration: duration ?? this.duration,
      venueType: venueType ?? this.venueType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      facilities: facilities ?? this.facilities,
      available: available ?? this.available,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'price': price,
      'sdPrice;': sdPrice,
      'location': location,
      'images': images,
      'description': description,
      'capacity': capacity,
      'duration': duration,
      'venueType': venueType,
      'phoneNumber': phoneNumber,
      'time': time,
      'facilities': facilities,
      'available': available,
      'privacyPolicy': privacyPolicy,
    };
  }

  // fromMap method
  factory VenueModel.fromMap(Map<String, dynamic> map) {
    return VenueModel(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      sdPrice: map['sdPrice'] ?? 0,
      location: List<String>.from(map['location'] ?? []),
      images: List<String>.from(map['images'] ?? []),
      description: map['description'] ?? '',
      capacity: map['capacity'] ?? 0,
      duration: map['duration'] ?? '',
      venueType: map['venueType'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      facilities: List<String>.from(map['facilities'] ?? []),
      available: map['available'] ?? false,
      privacyPolicy: map['privacyPolicy'] ?? false,
    );
  }

  // fromEntity method
  factory VenueModel.fromEntity(Venue entity) {
    return VenueModel(
      userId: entity.userId ?? '',
      name: entity.name ?? '',
      price: entity.price ?? 0,
      sdPrice: entity.sdPrice ?? 0,
      location: entity.location ?? [],
      images: entity.images ?? [],
      description: entity.description ?? '',
      capacity: entity.capacity ?? 0,
      duration: entity.duration ?? '',
      venueType: entity.venueType ?? '',
      phoneNumber: entity.phoneNumber ?? '',
      facilities: entity.facilities ?? [],
      available: entity.available ?? false,
      privacyPolicy: entity.privacyPolicy ?? false,
    );
  }

  // toEntity method
  Venue toEntity() {
    return Venue(
      name: name,
      price: price,
      sdPrice: sdPrice,
      location: location,
      images: images,
      description: description,
      capacity: capacity,
      duration: duration,
      venueType: venueType,
      phoneNumber: phoneNumber,
      facilities: facilities,
      available: available,
      privacyPolicy: privacyPolicy,
    );
  }
}
