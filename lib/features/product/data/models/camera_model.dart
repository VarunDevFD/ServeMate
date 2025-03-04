// import 'package:serve_mate/features/product/doamin/entities/camera_entity.dart';

class CameraModel {
  final String name;
  final double price;
  final double sdPrice;
  final String location;
  final List<String?>? images;
  final String notes;
  final String equipmentType;
  final String? brand;
  final String condition;
  final String date;
  final List<String?>? accessories;
  final String damage;

  CameraModel({
    this.name = '',
    this.price = 0,
    this.sdPrice = 0,
    this.location = '',
    this.images,
    this.notes = '',
    this.equipmentType = '',
    this.brand = '',
    this.condition = '',
    this.date = '',
    this.accessories,
    this.damage = '',
  });

  CameraModel copyWith({
    String? name,
    double? price,
    double? sdPrice,
    String? location,
    List<String?>? images,
    String? notes,
    String? equipmentType,
    String? brand,
    String? condition,
    String? date,
    List<String?>? accessories,
    String? damage,
  }) {
    return CameraModel(
      name: name ?? this.name,
      price: price ?? this.price,
      sdPrice: sdPrice ?? this.sdPrice,
      location: location ?? this.location,
      images: images ?? this.images,
      notes: notes ?? this.notes,
      equipmentType: equipmentType ?? this.equipmentType,
      brand: brand ?? this.brand,
      condition: condition ?? this.condition,
      date: date ?? this.date,
      accessories: accessories ?? this.accessories,
      damage: damage ?? this.damage,
    );
  }
}

// class CameraModel extends CameraEntity {
//   CameraModel({
//     required String name,
//     required double price,
//     required double securityDeposit,
//     required String location,
//     required List<String> images,
//     required String notes,
//     required String equipmentType,
//     required String brandModel,
//     required String condition,
//     required String dateAdded,
//     required List<String> accessories,
//     required String damage,
//   }) : super(
//           name: name,
//           price: price,
//           securityDeposit: securityDeposit,
//           location: location,
//           images: images,
//           notes: notes,
//           equipmentType: equipmentType,
//           brandModel: brandModel,
//           condition: condition,
//           dateAdded: dateAdded,
//           accessories: accessories,
//           damage: damage,
//         );

//   /// Convert the model into a Map for Firestore or local storage.
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'price': price,
//       'securityDeposit': securityDeposit,
//       'location': location,
//       'images': images,
//       'notes': notes,
//       'equipmentType': equipmentType,
//       'brandModel': brandModel,
//       'condition': condition,
//       'dateAdded': dateAdded,
//       'accessories': accessories,
//       'damage': damage,
//     };
//   }

//   /// Create a `CameraModel` object from a Map.
//   factory CameraModel.fromMap(Map<String, dynamic> map) {
//     return CameraModel(
//       name: map['name'] as String,
//       price: (map['price'] as num).toDouble(),
//       securityDeposit: (map['securityDeposit'] as num).toDouble(),
//       location: map['location'] as String,
//       images: List<String>.from(map['images'] ?? []),
//       notes: map['notes'] as String,
//       equipmentType: map['equipmentType'] as String,
//       brandModel: map['brandModel'] as String,
//       condition: map['condition'] as String,
//       dateAdded: map['dateAdded'] as String,
//       accessories: List<String>.from(map['accessories'] ?? []),
//       damage: map['damage'] as String,
//     );
//   }
// }
