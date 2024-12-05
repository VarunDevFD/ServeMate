class VehicleModel {
  String? name;
  String? brand;
  int? seatCapacity;
  String? registrationNumber;
  double? rentalPrice;
  double? securityDeposit;
  String? vehicleType; // e.g., Car, Bike, etc.
  String? model; // e.g., SUV, Sedan, etc.
  String? fuelType; // e.g., Petrol, Diesel, Electric
  String? transmission; // e.g., Manual, Automatic
  List<String>? facilities; // e.g., AC, GPS, Music System
  List<String>? images; // List of image URLs or file paths
  String? date; // Date of availability or listing
  String? location; // Location of the vehicle
  String? toggleOption; // e.g., Availability toggle (true/false)
  String? description;
  String? color;

  VehicleModel({
    this.name,
    this.brand,
    this.seatCapacity,
    this.registrationNumber,
    this.rentalPrice,
    this.securityDeposit,
    this.vehicleType,
    this.model,
    this.fuelType,
    this.transmission,
    this.facilities,
    this.images,
    this.date,
    this.location,
    this.toggleOption,
    this.description,
    this.color,
  });

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
      'name': name,
      'brand': brand,
      'seatCapacity': seatCapacity,
      'registrationNumber': registrationNumber,
      'rentalPrice': rentalPrice,
      'securityDeposit': securityDeposit,
      'vehicleType': vehicleType,
      'model': model,
      'fuelType': fuelType,
      'transmission': transmission,
      'facilities': facilities,
      'images': images,
      'date': date,
      'location': location,
      'toggleOption': toggleOption,
      'description': description,
      'color': color,
    };
  }
}
