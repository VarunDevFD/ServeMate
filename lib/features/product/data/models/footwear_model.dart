class FootwearModel {
  final String? name;
  final double? price;
  final String? brand;
  final double? securityDeposit;
  final String? description;
  final String? condition;
  final String? size;
  final String? color;
  final String? category;
  final String? isAvailable;
  final List<String>? images;
  final String? location;
  final String? date;
  

    FootwearModel({
    this.name,
    this.price,
    this.brand,
    this.securityDeposit,
    this.description,
    this.condition,
    this.size,
    this.color,
    this.category,
    this.isAvailable,
    this.images,
    this.location,
    this.date,
  });

  

  /// Converts the FootwearModel to a JSON map (useful for sending data to APIs or storing in a database)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'brand': brand,
      'securityDeposit': securityDeposit,
      'description': description,
      'condition': condition,
      'size': size,
      'color': color,
      'category': category,
      'isAvailable': isAvailable,
      'images': images,
      'location': location,
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
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      location: json['location'],
      date: json['date'],
    );
  }
}


