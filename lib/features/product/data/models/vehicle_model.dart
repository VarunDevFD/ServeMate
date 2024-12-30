import 'package:serve_mate/features/product/doamin/entities/vehicle_entity.dart';

class VehicleModel extends VehicleEntity {
  VehicleModel({
    required String name,
    required String model,
    required double rentalPrice,
    required double securityDeposit,
    required String location,
    required List<String> images,
    required String description,
    required String brand,
    required int seatCapacity,
    required String registrationNumber,
    required String vehicleType,
    required String fuelType,
    required String transmission,
    required List<String> facilities,
    required String date,
    required String toggleOption,
    required String color,
  }) : super(
          name: name,
          model: model,
          brand: brand,
          price: rentalPrice,
          description: description,
          image: images.isNotEmpty
              ? images[0]
              : '', // Just an example for the image field
          type: vehicleType,
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
          toggleOption: toggleOption,
          color: color,
        );

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
      toggleOption: json['toggleOption'] ?? '',
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
      'vehicleType': type,
      'fuelType': fuelType,
      'transmission': transmission,
      'facilities': facilities,
      'date': date,
      'toggleOption': toggleOption,
      'color': color,
    };
  }
}
