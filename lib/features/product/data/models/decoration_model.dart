import 'package:serve_mate/features/product/data/models/rental_model.dart';

class DecorationItem extends RentalItem {
  List<String>? selectedFacilitiesFirst;
  List<String>? selectedFacilitiesSecond;
  String? date;

  // Constructor
  DecorationItem({
    String? name,
    double? rentalPrice,
    double? securityDeposit,
    String? location,
    List<String>? imageUrls,
    String? description,
    this.selectedFacilitiesFirst,
    this.selectedFacilitiesSecond,
    this.date,
  }) : super(
          name: name,
          price: rentalPrice,
          securityDeposit: securityDeposit,
          location: location,
          images: imageUrls,
          description: description,
        );

  // Method to convert the model into a Map for saving to a database
  @override
  Map<String, dynamic> toMap() {
    return {
      'selectedFacilitiesFirst': selectedFacilitiesFirst,
      'securityDeposit': securityDeposit,
      'selectedFacilitiesSecond': selectedFacilitiesSecond,
      'date': date,
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
