import 'package:serve_mate/features/product/doamin/entities/camera.dart';

class CameraModel {
  final String userId;
  final String time = DateTime.now().toString();
  final String name;
  final String brand;
  final String model;
  final String description;
  final String category;
  final int price;
  final int sdPrice;
  final bool available;
  final List<String> location;
  final String phoneNumber;
  final String condition;
  final List<String>? storage;
  final List<String>? connectivity;
  final String duration;
  final String latePolicy;
  final List<String> images;
  final bool privacyPolicy;

  CameraModel({
    required this.userId, 
    required this.name,
    required this.brand,
    required this.model,
    required this.category,
    required this.description,
    required this.price,
    required this.sdPrice,
    required this.available,
    required this.location,
    required this.phoneNumber,
    required this.condition,
    required this.storage,
    required this.connectivity,
    required this.duration,
    required this.latePolicy,
    required this.images,
    required this.privacyPolicy,
  });

  CameraModel copyWith({
    String? userId,
    String? time,
    String? name,
    String? model,
    String? brand,
    String? category,
    String? description,
    int? price,
    int? sdPrice,
    bool? available,
    List<String>? location,
    String? phoneNumber,
    String? condition,
    List<String>? storage,
    List<String>? connectivity,
    String? duration,
    String? latePolicy,
    List<String>? images,
    bool? privacyPolicy,
  }) {
    return CameraModel(
      userId: userId ?? this.userId, 
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      category: category ?? this.category,
      description: description ?? this.description,
      price: price ?? this.price,
      sdPrice: sdPrice ?? this.sdPrice,
      available: available ?? this.available,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      condition: condition ?? this.condition,
      storage: storage ?? this.storage,
      connectivity: connectivity ?? this.connectivity,
      duration: duration ?? this.duration,
      latePolicy: latePolicy ?? this.latePolicy,
      images: images ?? this.images,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'time' : time,
      'name': name,
      'brand': brand,
      'model': model,
      'description': description,
      'category': category,
      'price': price, 
      'sdPrice': sdPrice,
      'available': available,
      'location': location,
      'phoneNumber': phoneNumber,
      'condition': condition,
      'storageOption': storage,  
      'connectivityOptions': connectivity,  
      'duration': duration,
      'latePolicy': latePolicy,
      'images': images,
      'privacyPolicy': privacyPolicy,
    };
  }

  factory CameraModel.fromMap(Map<String, dynamic> map) {
    return CameraModel(

      userId: map['userId'] as String? ?? '', 
      name: map['name'] as String? ?? '',
      brand: map['brand'] as String? ?? '',
      model: map['model'] as String? ?? '',
      description: map['description'] as String? ?? '',
      category: map['category'] as String? ?? '',
      price: map['price'] as int? ?? 0,
      sdPrice: map['sdPrice'] as int? ?? 0,
      available: map['available'] as bool? ?? false,
      location: List<String>.from(map['location'] ?? ['', '', '']),
      phoneNumber: map['phoneNumber'] as String? ?? '',
      condition: map['condition'] as String? ?? '',
      storage: List<String>.from(map['storageOption'] ?? []),
      connectivity: List<String>.from(map['connectivityOptions'] ?? []),
      duration: map['duration'] as String? ?? '',
      latePolicy: map['latePolicy'] as String? ?? '',
      images: List<String>.from(map['images'] ?? []),
      privacyPolicy: map['privacyPolicy'] as bool? ?? false,
    );
  }

  // New factory method to convert from Camera entity
  factory CameraModel.fromEntity(Camera camera) {
    return CameraModel(
      userId: camera.userId ?? '', 
      name: camera.name ?? '',
      brand: camera.brand ?? '',
      model: camera.model ?? '',
      category: camera.category ?? '',
      description: camera.description ?? '',
      price: camera.price ?? 0,
      sdPrice: camera.sdPrice ?? 0,
      available: camera.available ?? false,
      location: camera.location ?? ['', '', ''],
      phoneNumber: camera.phoneNumber ?? '',
      condition: camera.condition ?? '',
      storage: camera.storage,
      connectivity: camera.connectivity,
      duration: camera.duration ?? '',
      latePolicy: camera.latePolicy ?? '',
      images: camera.images ?? [],
      privacyPolicy: camera.privacyPolicy ?? false,
    );
  }

  Camera toEntity() {
    return Camera(
      userId: userId,
      time: time,
      name: name,
      brand: brand,
      model: model,
      category: category,
      description: description,
      price: price,
      sdPrice: sdPrice,
      available: available,
      location: location,
      phoneNumber: phoneNumber,
      condition: condition,
      storage: storage,
      connectivity: connectivity,
      duration: duration,
      latePolicy: latePolicy,
      images: images,
      privacyPolicy: privacyPolicy,
    );
  }
}
