import 'package:serve_mate/features/product/doamin/entities/decoration_entity.dart';

class DecorationItem extends DecorationEntity {
  DecorationItem({
    required String name,
    required double rentalPrice,
    required double securityDeposit,
    required String location,
    required List<String> imageUrls,
    required String description,
    required List<String> selectedFacilitiesFirst,
    required List<String> selectedFacilitiesSecond,
    required String date,
  }) : super(
          name: name,
          rentalPrice: rentalPrice,
          securityDeposit: securityDeposit,
          location: location,
          imageUrls: imageUrls,
          description: description,
          selectedFacilitiesFirst: selectedFacilitiesFirst,
          selectedFacilitiesSecond: selectedFacilitiesSecond,
          date: date,
        );

  // Method to convert the model into a Map for saving to a database
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rentalPrice': rentalPrice,
      'securityDeposit': securityDeposit,
      'location': location,
      'imageUrls': imageUrls,
      'description': description,
      'selectedFacilitiesFirst': selectedFacilitiesFirst,
      'selectedFacilitiesSecond': selectedFacilitiesSecond,
      'date': date,
    };
  }

  // Method to create a model instance from a Map (e.g., fetched from a database)
  factory DecorationItem.fromMap(Map<String, dynamic> map) {
    return DecorationItem(
      name: map['name'],
      rentalPrice: map['rentalPrice'],
      securityDeposit: map['securityDeposit'],
      location: map['location'],
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      description: map['description'],
      selectedFacilitiesFirst:
          List<String>.from(map['selectedFacilitiesFirst'] ?? []),
      selectedFacilitiesSecond:
          List<String>.from(map['selectedFacilitiesSecond'] ?? []),
      date: map['date'],
    );
  }
}
