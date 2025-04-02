import 'package:serve_mate/features/product/doamin/entities/venue.dart';

class VenueModel {
  final String name;
  final int rentalPrice;
  final int securityDeposit;
  final List<String> location;
  final List<String> images;
  final String description;
  final int capacity;
  final String duration;
  final String venueType;
  final String phoneNumber;
  final String date;
  final List<String> facilities;
  final bool isAvailable;
  final bool privacyPolicy;

  VenueModel({
    required this.name,
    required this.rentalPrice,
    required this.securityDeposit,
    required this.location,
    required this.images,
    required this.description,
    required this.capacity,
    required this.duration,
    required this.venueType,
    required this.phoneNumber,
    required this.date,
    required this.facilities,
    required this.isAvailable,
    required this.privacyPolicy,
  });

  // copyWith method
  VenueModel copyWith({
    String? name,
    int? rentalPrice,
    int? securityDeposit,
    List<String>? location,
    List<String>? images,
    String? description,
    int? capacity,
    String? duration,
    String? venueType,
    String? phoneNumber,
    String? date,
    List<String>? facilities,
    bool? isAvailable,
    bool? privacyPolicy,
  }) {
    return VenueModel(
      name: name ?? this.name,
      rentalPrice: rentalPrice ?? this.rentalPrice,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      location: location ?? this.location,
      images: images ?? this.images,
      description: description ?? this.description,
      capacity: capacity ?? this.capacity,
      duration: duration ?? this.duration,
      venueType: venueType ?? this.venueType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      date: date ?? this.date,
      facilities: facilities ?? this.facilities,
      isAvailable: isAvailable ?? this.isAvailable,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rentalPrice': rentalPrice,
      'securityDeposit': securityDeposit,
      'location': location,
      'images': images,
      'description': description,
      'capacity': capacity,
      'duration': duration,
      'venueType': venueType,
      'phoneNumber': phoneNumber,
      'date': date,
      'facilities': facilities,
      'isAvailable': isAvailable,
      'privacyPolicy': privacyPolicy,
    };
  }

  // fromMap method
  factory VenueModel.fromMap(Map<String, dynamic> map) {
    return VenueModel(
      name: map['name'] ?? '',
      rentalPrice: map['rentalPrice'] ?? 0,
      securityDeposit: map['securityDeposit'] ?? 0,
      location: List<String>.from(map['location'] ?? []),
      images: List<String>.from(map['images'] ?? []),
      description: map['description'] ?? '',
      capacity: map['capacity'] ?? 0,
      duration: map['duration'] ?? '',
      venueType: map['venueType'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      date: map['date'] ?? '',
      facilities: List<String>.from(map['facilities'] ?? []),
      isAvailable: map['isAvailable'] ?? false,
      privacyPolicy: map['privacyPolicy'] ?? false,
    );
  }

  // fromEntity method
  factory VenueModel.fromEntity(Venue entity) {
    return VenueModel(
      name: entity.name,
      rentalPrice: entity.rentalPrice,
      securityDeposit: entity.securityDeposit,
      location: entity.location,
      images: entity.images,
      description: entity.description,
      capacity: entity.capacity,
      duration: entity.duration,
      venueType: entity.venueType,
      phoneNumber: entity.phoneNumber,
      date: entity.date,
      facilities: entity.facilities,
      isAvailable: entity.isAvailable,
      privacyPolicy: entity.privacyPolicy,
    );
  }

  // toEntity method
  Venue toEntity() {
    return Venue(
      name: name,
      rentalPrice: rentalPrice,
      securityDeposit: securityDeposit,
      location: location,
      images: images,
      description: description,
      capacity: capacity,
      duration: duration,
      venueType: venueType,
      phoneNumber: phoneNumber,
      date: date,
      facilities: facilities,
      isAvailable: isAvailable,
      privacyPolicy: privacyPolicy,
    );
  }
}
