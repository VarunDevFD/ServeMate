class VehicleEntity {
  final String name;
  final String model;
  final String brand;
  final double price;
  final String description;
  final String image;
  final String type;
  final double rentalPrice;
  final double securityDeposit;
  final String location;
  final List<String> images;
  final int seatCapacity;
  final String registrationNumber;
  final String fuelType;
  final String transmission;
  final List<String> facilities;
  final String date;
  final String toggleOption;
  final String color;

  VehicleEntity({
    required this.name,
    required this.model,
    required this.brand,
    required this.price,
    required this.description,
    required this.image,
    required this.type,
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
    required this.toggleOption,
    required this.color,
  });
}
