import 'package:serve_mate/features/product/data/models/rental_model.dart';

class VehicleModel extends RentalItem {
  String? brand;
  int? seatCapacity;
  String? registrationNumber;
  String? vehicleType; // e.g., Car, Bike, etc.
  String? model; // e.g., SUV, Sedan, etc.
  String? fuelType; // e.g., Petrol, Diesel, Electric
  String? transmission; // e.g., Manual, Automatic
  List<String>? facilities; // e.g., AC, GPS, Music System
  String? date; // Date of availability or listing
  String? toggleOption; // e.g., Availability toggle (true/false)
  String? color;

  VehicleModel({
    String? name,
    double? rentalPrice,
    double? securityDeposit,
    String? location,
    List<String>? images,
    String? description,
    this.brand,
    this.seatCapacity,
    this.registrationNumber,
    this.vehicleType,
    this.model,
    this.fuelType,
    this.transmission,
    this.facilities,
    this.date,
    this.toggleOption,
    this.color,
  }) : super(
          name: name,
          price: rentalPrice,
          securityDeposit: securityDeposit,
          location: location,
          images: images,
          description: description,
        );

  // Factory constructor for creating a VehicleModel from a JSON map
  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      name: json['name'],
      brand: json['brand'],
      seatCapacity: json['seatCapacity'],
      registrationNumber: json['registrationNumber'],
      rentalPrice: json['rentalPrice']?.toDouble() ?? 0.0,
      securityDeposit: json['securityDeposit']?.toDouble() ?? 0.0,
      vehicleType: json['vehicleType'],
      model: json['model'],
      fuelType: json['fuelType'],
      transmission: json['transmission'],
      facilities: List<String>.from(json['facilities'] ?? []),
      images: List<String>.from(json['images'] ?? []),
      date: json['date'],
      location: json['location'],
      toggleOption: json['toggleOption'],
      description: json['description'],
      color: json['color'],
    );
  }

  // Convert VehicleModel to JSON map
  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'seatCapacity': seatCapacity,
      'registrationNumber': registrationNumber,
      'vehicleType': vehicleType,
      'model': model,
      'fuelType': fuelType,
      'transmission': transmission,
      'facilities': facilities,
      'date': date,
      'toggleOption': toggleOption,
      'color': color,
    };
  }
}
