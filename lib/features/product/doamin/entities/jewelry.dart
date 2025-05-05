class Jewelry {
  final String? id;
  final String? userId;
  final String? name;
  final int? price;
  final int? securityDeposit;
  final List<String>? location;
  final List<String>? images;
  final String? description;
  final String? type;
  final String? material;
  final String? quantity;
  final String? condition;
  final String? brand;
  final bool? available; 
  final String? phoneNumber;
  final bool? privacyPolicy;
  final String? permission;

  Jewelry({
    this.id,
    this.userId,
    required this.name,
    required this.price,
    required this.securityDeposit,
    required this.location,
    required this.images,
    required this.description,
    required this.type,
    required this.material,
    required this.quantity,
    required this.condition,
    required this.brand,
    required this.available, 
    required this.phoneNumber,
    required this.privacyPolicy,
    required this.permission,
  });

  Jewelry copyWith({
    String? id,
    String? userId,
    String? name,
    int? price,
    int? securityDeposit,
    List<String>? location,
    List<String>? images,
    String? description,
    String? type,
    String? material,
    String? quantity,
    String? condition,
    String? brand,
    bool? available, 
    String? phoneNumber,
    bool? privacyPolicy,
    String? permission,
  }) {
    return Jewelry(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      price: price ?? this.price,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      location: location ?? this.location,
      images: images ?? this.images,
      description: description ?? this.description,
      type: type ?? this.type,
      material: material ?? this.material,
      quantity: quantity ?? this.quantity,
      condition: condition ?? this.condition,
      brand: brand ?? this.brand,
      available: available ?? available, 
      phoneNumber: phoneNumber ?? phoneNumber,
      privacyPolicy: privacyPolicy ?? privacyPolicy,
      permission: permission ?? permission,
    );
  }

  static empty() {
    return Jewelry(
      id: '',
      userId: '',
      name: '',
      price: 0,
      securityDeposit: 0,
      location: [],
      images: [],
      description: '',
      type: '',
      material: '',
      quantity: '',
      condition: '',
      brand: '',
      available: false, 
      phoneNumber: '',
      privacyPolicy: false,
      permission: '',
    );
  }
}
