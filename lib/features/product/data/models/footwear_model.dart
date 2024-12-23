import 'package:serve_mate/features/product/data/models/rental_model.dart';

class FootwearModel extends RentalItem {
  final String? brand;
  final String? condition;
  final String? size;
  final String? color;
  final String? category;
  final String? isAvailable;
  final String? date;

  FootwearModel({
    String? name,
    double? price,
    double? securityDeposit,
    String? location,
    List<String>? images,
    String? description,
    this.brand,
    this.condition,
    this.size,
    this.color,
    this.category,
    this.isAvailable,
    this.date,
  }) : super(
          name: name,
          price: price,
          securityDeposit: securityDeposit,
          location: location,
          images: images,
          description: description,
        );

  /// Converts the FootwearModel to a JSON map (useful for sending data to APIs or storing in a database)
  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'condition': condition,
      'size': size,
      'color': color,
      'category': category,
      'isAvailable': isAvailable,
      'dateAdded': date,
    };
  }

  /// Factory constructor to create a FootwearModel object from a JSON map
  factory FootwearModel.fromJson(Map<String, dynamic> json) {
    return FootwearModel(
      name: json['name'],
      price: (json['price'] as num?)?.toDouble(),
      brand: json['brand'],
      securityDeposit: (json['securityDeposit'] as num?)?.toDouble(),
      description: json['description'],
      condition: json['condition'],
      size: json['size'],
      color: json['color'],
      category: json['category'],
      isAvailable: json['isAvailable'],
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      location: json['location'],
      date: json['date'],
    );
  }
}
