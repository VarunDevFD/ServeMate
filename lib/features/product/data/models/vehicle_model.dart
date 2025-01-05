import 'package:serve_mate/features/product/doamin/entities/vehicle_entity.dart';

class VehicleModel extends VehicleEntity {
  VehicleModel({
    required String name,
    required String vehicleType,
    required String brand,
    required String model,
    required String color,
    required int seatCapacity,
    required String fuelType,
    required String transmission,
    required String registrationNumber,
    required double rentalPrice,
    required double securityDeposit,
    required String date,
    required List<String> facilities,
    required List<String> images,
    required String location,
    required String availability,
    String? description,
  }) : super(
          name: name,
          model: model,
          brand: brand,
          price: rentalPrice,
          description: description,
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
          availability: availability,
          color: color,
        );

  // CopyWith method to update specific fields
  VehicleModel copyWith({
    String? name,
    String? model,
    String? vehicleType,
    double? rentalPrice,
    double? securityDeposit,
    String? location,
    List<String>? images,
    String? description,
    String? brand,
    int? seatCapacity,
    String? registrationNumber,
    String? fuelType,
    String? transmission,
    List<String>? facilities,
    String? date,
    String? availability,
    String? color,
  }) {
    return VehicleModel(
      name: name ?? this.name,
      model: model ?? this.model,
      vehicleType: vehicleType ?? this.vehicleType,
      rentalPrice: rentalPrice ?? this.rentalPrice,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      location: location ?? this.location,
      images: images ?? this.images,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      seatCapacity: seatCapacity ?? this.seatCapacity,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      fuelType: fuelType ?? this.fuelType,
      transmission: transmission ?? this.transmission,
      facilities: facilities ?? this.facilities,
      date: date ?? this.date,
      availability: availability ?? this.availability,
      color: color ?? this.color,
    );
  }

  // Factory constructor for creating a VehicleModel object from a JSON map
  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      name: json['name'] ?? '',
      model: json['model'] ?? '',
      rentalPrice: (json['rentalPrice'] as num?)?.toDouble() ?? 0.0,
      securityDeposit: (json['securityDeposit'] as num?)?.toDouble() ?? 0.0,
      location: json['location'] ?? '',
      images: List<String>.from(json['images'] ?? ['', '']),
      description: json['description'] ?? '',
      brand: json['brand'] ?? '',
      seatCapacity: json['seatCapacity'] ?? 0,
      registrationNumber: json['registrationNumber'] ?? '',
      vehicleType: json['vehicleType'] ?? '',
      fuelType: json['fuelType'] ?? '',
      transmission: json['transmission'] ?? '',
      facilities: List<String>.from(json['facilities'] ?? []),
      date: json['date'] ?? '',
      availability: json['availability'] ?? '',
      color: json['color'] ?? '',
    );
  }

  // Converts the VehicleModel object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'model': model,
      'rentalPrice': rentalPrice,
      'securityDeposit': securityDeposit,
      'location': location,
      'images': images,
      'description': description,
      'brand': brand,
      'seatCapacity': seatCapacity,
      'registrationNumber': registrationNumber,
      'vehicleType': vehicleType,
      'fuelType': fuelType,
      'transmission': transmission,
      'facilities': facilities,
      'date': date,
      'availability': availability,
      'color': color,
    };
  }
}
