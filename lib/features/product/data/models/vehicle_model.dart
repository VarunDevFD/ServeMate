import 'package:serve_mate/features/product/doamin/entities/vehicle.dart';

class VehicleModel {
  final String name;
  final String model;
  final String brand;
  final int price;
  final String vehicleType;
  final int rentalPrice;
  final int securityDeposit;
  final List<String> location;
  final List<String> images;
  final int seatCapacity;
  final String registrationNumber;
  final String fuelType;
  final String transmission;
  final List<String> facilities;
  final String date;
  final String color;
  final bool availability;
  final bool privacyPolicy;
  final String? description;

  VehicleModel({
    required this.name,
    required this.model,
    required this.brand,
    required this.price,
    required this.vehicleType,
    required this.rentalPrice,
    required this.securityDeposit,
    required this.location,
    required this.images,
    required this.seatCapacity,
    required this.registrationNumber,
    required this.fuelType,
    required this.transmission,
    required this.facilities,
    required this.date,
    required this.color,
    required this.availability,
    required this.privacyPolicy,
    this.description,
  });

  // copyWith method
  VehicleModel copyWith({
    String? name,
    String? model,
    String? brand,
    int? price,
    String? vehicleType,
    int? rentalPrice,
    int? securityDeposit,
    List<String>? location,
    List<String>? images,
    int? seatCapacity,
    String? registrationNumber,
    String? fuelType,
    String? transmission,
    List<String>? facilities,
    String? date,
    String? color,
    bool? availability,
    bool? privacyPolicy,
    String? description,
  }) {
    return VehicleModel(
      name: name ?? this.name,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      price: price ?? this.price,
      vehicleType: vehicleType ?? this.vehicleType,
      rentalPrice: rentalPrice ?? this.rentalPrice,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      location: location ?? this.location,
      images: images ?? this.images,
      seatCapacity: seatCapacity ?? this.seatCapacity,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      fuelType: fuelType ?? this.fuelType,
      transmission: transmission ?? this.transmission,
      facilities: facilities ?? this.facilities,
      date: date ?? this.date,
      color: color ?? this.color,
      availability: availability ?? this.availability,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      description: description ?? this.description,
    );
  }

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'model': model,
      'brand': brand,
      'price': price,
      'vehicleType': vehicleType,
      'rentalPrice': rentalPrice,
      'securityDeposit': securityDeposit,
      'location': location,
      'images': images,
      'seatCapacity': seatCapacity,
      'registrationNumber': registrationNumber,
      'fuelType': fuelType,
      'transmission': transmission,
      'facilities': facilities,
      'date': date,
      'color': color,
      'availability': availability,
      'privacyPolicy': privacyPolicy,
      'description': description,
    };
  }


  // fromMap method
  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      name: map['name'] ?? '',
      model: map['model'] ?? '',
      brand: map['brand'] ?? '',
      price: map['price'] ?? 0,
      vehicleType: map['vehicleType'] ?? '',
      rentalPrice: map['rentalPrice'] ?? 0,
      securityDeposit: map['securityDeposit'] ?? 0,
      location: map['location'] ?? [],
      images: List<String>.from(map['images'] ?? []),
      seatCapacity: map['seatCapacity'] ?? 0,
      registrationNumber: map['registrationNumber'] ?? '',
      fuelType: map['fuelType'] ?? '',
      transmission: map['transmission'] ?? '',
      facilities: List<String>.from(map['facilities'] ?? []),
      date: map['date'] ?? '',
      color: map['color'] ?? '',
      availability: map['availability'] ?? false,
      privacyPolicy: map['privacyPolicy'] ?? false,
      description: map['description'],
    );
  }

  // fromEntity method
  factory VehicleModel.fromEntity(Vehicle entity) {
    return VehicleModel(
      name: entity.name,
      model: entity.model,
      brand: entity.brand,
      price: entity.price,
      vehicleType: entity.vehicleType,
      rentalPrice: entity.rentalPrice,
      securityDeposit: entity.securityDeposit,
      location: entity.location,
      images: entity.images,
      seatCapacity: entity.seatCapacity,
      registrationNumber: entity.registrationNumber,
      fuelType: entity.fuelType,
      transmission: entity.transmission,
      facilities: entity.facilities,
      date: entity.date,
      color: entity.color,
      availability: entity.availability,
      privacyPolicy: entity.privacyPolicy,
      description: entity.description,
    );
  }


  // toEntity method
  Vehicle toEntity() {
    return Vehicle(
      name: name,
      model: model,
      brand: brand,
      price: price,
      vehicleType: vehicleType,
      rentalPrice: rentalPrice,
      securityDeposit: securityDeposit,
      location: location,
      images: images,
      seatCapacity: seatCapacity,
      registrationNumber: registrationNumber,
      fuelType: fuelType,
      transmission: transmission,
      facilities: facilities,
      date: date,
      color: color,
      availability: availability,
      privacyPolicy: privacyPolicy,
      description: description,
    );
  }
}
