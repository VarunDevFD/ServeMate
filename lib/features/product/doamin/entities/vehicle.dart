class Vehicle {
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

  Vehicle({
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
    required this.availability,
    required this.privacyPolicy,
    required this.color,
    this.description,
  });

  Vehicle copyWith({
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
    bool? availability,
    bool? privacyPolicy,
    String? color,
    String? description,
  }) {
    return Vehicle(
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
      availability: availability ?? this.availability,
       privacyPolicy:  privacyPolicy ?? this. privacyPolicy,
      color: color ?? this.color,
      description: description ?? this.description,
    );
  }

  static empty() {
    return Vehicle(
      name: '',
      model: '',
      brand: '',
      price: 0,
      vehicleType: '',
      rentalPrice: 0,
      securityDeposit: 0,
      location: [],
      images: [],
      seatCapacity: 0,
      registrationNumber: '',
      fuelType: '',
      transmission: '',
      facilities: [],
      date: '',
      availability: false,
      privacyPolicy: false,
      color: '',
      description: '',
    );
  }
}
