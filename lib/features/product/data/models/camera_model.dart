// import 'package:serve_mate/features/product/doamin/entities/camera_entity.dart';

class CameraModel {
  final String name;
  final String brand;
  final String model;
  final String description;
  final num price;
  final num sdPrice;
  final bool available;
  final String location;
  final String phoneNumber;
  final String condition;
  final List<String> storageOption;
  final List<String> connectivityOptions;
  final String duration;
  final String latePolicy;
  final List<String> images;
  final bool privacyPolicy;

  CameraModel({
    required this.name,
    required this.brand,
    required this.model,
    required this.description,
    required this.price,
    required this.sdPrice,
    required this.available,
    required this.location,
    required this.phoneNumber,
    required this.condition,
    required this.storageOption,
    required this.connectivityOptions,
    required this.duration,
    required this.latePolicy,
    required this.images,
    required this.privacyPolicy,
  });

  CameraModel copyWith({
    String? name,
    String? brand,
    String? model,
    String? description,
    num? price,
    num? sdPrice,
    bool? available,
    String? location,
    String? phoneNumber,
    String? condition,
    List<String>? storageOption,
    List<String>? connectivityOptions,
    String? duration,
    String? latePolicy,
    List<String>? images,
    bool? privacyPolicy,
  }) {
    return CameraModel(
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      description: description ?? this.description,
      price: price ?? this.price,
      sdPrice: sdPrice ?? this.sdPrice,
      available: available ?? this.available,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      condition: condition ?? this.condition,
      storageOption: storageOption ?? this.storageOption,
      connectivityOptions: connectivityOptions ?? this.connectivityOptions,
      duration: duration ?? this.duration,
      latePolicy: latePolicy ?? this.latePolicy,
      images: images ?? this.images,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'model': model,
      'description': description,
      'price': price,
      'sdPrice': sdPrice,
      'available': available,
      'location': location,
      'phoneNumber': phoneNumber,
      'condition': condition,
      'storageOption': storageOption,
      'connectivityOptions': connectivityOptions,
      'duration': duration,
      'latePolicy': latePolicy,
      'images': images,
      'privacyPolicy': privacyPolicy,
    };
  }

  factory CameraModel.fromMap(Map<String, dynamic> map) {
    return CameraModel(
      name: map['name'] as String,
      brand: map['brand'] as String,
      model: map['model'] as String,
      description: map['description'] as String,
      price: map['price'] as num,
      sdPrice: map['sdPrice'] as num,
      available: map['available'] as bool,
      location: map['location'] as String,
      phoneNumber: map['phoneNumber'] as String,
      condition: map['condition'] as String,
      storageOption: List<String>.from(map['storageOption'] ?? []),
      connectivityOptions: List<String>.from(map['connectivityOptions'] ?? []),
      duration: map['duration'] as String,
      latePolicy: map['latePolicy'] as String,
      images: List<String>.from(map['images'] ?? []),
      privacyPolicy: map['privacyPolicy'] as bool,
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
