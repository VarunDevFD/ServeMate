import 'package:serve_mate/features/product/doamin/entities/decoration_entity.dart';

class DecorationModel extends DecorationEntity {
  DecorationModel({
    required String name,
    required double rentalPrice,
    required double securityDeposit,
    required String location,
    required List<String> images,
    required String description,
    required List<String> selectedFacilitiesFirst,
    required List<String> selectedFacilitiesSecond,
    required String date,
  }) : super(
          name: name,
          rentalPrice: rentalPrice,
          securityDeposit: securityDeposit,
          location: location,
          images: images,
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
      'images': images,
      'description': description,
      'selectedFacilitiesFirst': selectedFacilitiesFirst,
      'selectedFacilitiesSecond': selectedFacilitiesSecond,
      'date': date,
    };
  }

  // Method to create a model instance from a Map (e.g., fetched from a database)
  factory DecorationModel.fromMap(Map<String, dynamic> map) {
    return DecorationModel(
      name: map['name'],
      rentalPrice: map['rentalPrice'],
      securityDeposit: map['securityDeposit'],
      location: map['location'],
      images: List<String>.from(map['images'] ?? []),
      description: map['description'],
      selectedFacilitiesFirst:
          List<String>.from(map['selectedFacilitiesFirst'] ?? []),
      selectedFacilitiesSecond:
          List<String>.from(map['selectedFacilitiesSecond'] ?? []),
      date: map['date'],
    );
  }
}
