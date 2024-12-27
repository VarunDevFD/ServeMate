class CameraEntity {
  final String name;
  final double price;
  final double securityDeposit;
  final String location;
  final List<String> images;
  final String notes;
  final String equipmentType;
  final String brandModel;
  final String condition;
  final String dateAdded;
  final List<String> accessories;
  final String damage;

  CameraEntity({
    required this.name,
    required this.price,
    required this.securityDeposit,
    required this.location,
    required this.images,
    required this.notes,
    required this.equipmentType,
    required this.brandModel,
    required this.condition,
    required this.dateAdded,
    required this.accessories,
    required this.damage,
  });
}
