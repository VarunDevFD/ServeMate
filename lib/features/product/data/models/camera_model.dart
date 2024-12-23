import 'package:serve_mate/features/product/data/models/rental_model.dart';

/*
class CameraModel {
  String? cameraName;
  String? equipmentType;
  String? brandModel;
  double? rentalPrice;
  double? securityDeposit;
  String? condition;
  String? date;
  List<String>? accessories;
  String? location;
  String? damage;
  String? notes;
  List<String>? imageUrls;

  CameraModel({
    this.cameraName,
    this.equipmentType,
    this.brandModel,
    this.rentalPrice,
    this.securityDeposit,
    this.condition,
    this.date,
    this.accessories,
    this.location,
    this.damage,
    this.notes,
    this.imageUrls,
  });


  /// Convert a Camera object into a map for Firestore or local storage.
  Map<String, dynamic> toMap() {
    return {
      'cameraName': cameraName,
      'equipmentType': equipmentType,
      'brandModel': brandModel,
      'rentalPrice': rentalPrice,
      'securityDeposit': securityDeposit,
      'condition': condition,
      'date': date,
      'accessories': accessories,
      'location': location,
      'damage': damage,
      'notes': notes,
      'imageUrls': imageUrls,
    };
  }

  /// Create a Camera object from a map (useful for retrieving data from Firestore or local storage).
  factory CameraModel.fromMap(Map<String, dynamic> map) {
    return CameraModel(
      cameraName: map['cameraName'] as String?,
      equipmentType: map['equipmentType'] ?? '',
      brandModel: map['brandModel'] ?? '',
      rentalPrice: map['rentalPrice']?.toDouble() ?? 0.0,
      securityDeposit: map['securityDeposit']?.toDouble() ?? 0.0,
      condition: map['condition'] ?? '',
      date: map['date'] as String?,
      accessories: List<String>.from(map['accessories'] ?? []),
      location: map['pickupOption'] ?? '',
      damage: map['damage'] ?? false,
      notes: map['notes'] as String,
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
    );
  }
*/
class CameraModel extends RentalItem {
  final String? equipmentType;
  final String? brandModel;
  final String? condition;
  final String? dateAdded;
  final List<String>? accessories;
  final String? damage;

  CameraModel({
    String? name,
    double? price,
    double? securityDeposit,
    String? location,
    List<String>? images,
    String? notes,
    this.equipmentType,
    this.brandModel,
    this.condition,
    this.dateAdded,
    this.accessories,
    this.damage,
  }) : super(
          name: name,
          price: price,
          securityDeposit: securityDeposit,
          location: location,
          images: images,
          description: notes,
        );

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'equipmentType': equipmentType,
        'brandModel': brandModel,
        'condition': condition,
        'dateAdded': dateAdded,
        'accessories': accessories,
        'damage': damage,
      });
  }

  factory CameraModel.fromMap(Map<String, dynamic> map) {
    return CameraModel(
      name: map['name'],
      price: (map['price'] as num?)?.toDouble(),
      securityDeposit: (map['securityDeposit'] as num?)?.toDouble(),
      location: map['location'],
      images: List<String>.from(map['images'] ?? []),
      equipmentType: map['equipmentType'],
      brandModel: map['brandModel'],
      condition: map['condition'],
      dateAdded: map['dateAdded'],
      accessories: List<String>.from(map['accessories'] ?? []),
      damage: map['damage'],
      notes: map['notes'],
    );
  }
}
