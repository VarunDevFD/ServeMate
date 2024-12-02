class DecorationItem {
  String? name; // Name of the decoration item
  List<String>?
      selectedFacilitiesFirst; // Selected facilities in the first list
  double? rentalPrice; // Rental price per day
  double? securityDeposit; // Security deposit amount
  List<String>? imageUrls; // List of image URLs or file paths
  List<String>?
      selectedFacilitiesSecond; // Selected facilities in the second list
  String? date;
  String? location; // Pickup/Delivery location
  String? description; // Description of the item

  // Constructor
  DecorationItem({
    this.name,
    this.selectedFacilitiesFirst,
    this.rentalPrice,
    this.securityDeposit,
    this.imageUrls,
    this.selectedFacilitiesSecond,
    this.date,
    this.location,
    this.description,
  });

  // Method to convert the model into a Map for saving to a database
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'selectedFacilitiesFirst': selectedFacilitiesFirst,
      'rentalPrice': rentalPrice,
      'securityDeposit': securityDeposit,
      'imageUrls': imageUrls,
      'selectedFacilitiesSecond': selectedFacilitiesSecond,
      'date': date,
      'location': location,
      'description': description,
    };
  }

  // Method to create a model instance from a Map (e.g., fetched from a database)
  factory DecorationItem.fromMap(Map<String, dynamic> map) {
    return DecorationItem(
      name: map['name'],
      selectedFacilitiesFirst:
          List<String>.from(map['selectedFacilitiesFirst'] ?? []),
      rentalPrice: map['rentalPrice'],
      securityDeposit: map['securityDeposit'],
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      selectedFacilitiesSecond:
          List<String>.from(map['selectedFacilitiesSecond'] ?? []),
      date: map['availableFrom'],
      location: map['location'],
      description: map['description'],
    );
  }
}
