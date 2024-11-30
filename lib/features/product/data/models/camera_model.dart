class Camera {
  final String cameraName;
  final String equipmentType;
  final String brandModel;
  final double rentalPrice;
  final double securityDeposit;
  final String condition;
  final List<DateTime> availabilityDates;
  final List<String> accessories;
  final String pickupOption;
  final bool hasInsurance;
  final String notes;
  final List<String> imageUrls;

  Camera({
    required this.cameraName,
    required this.equipmentType,
    required this.brandModel,
    required this.rentalPrice,
    required this.securityDeposit,
    required this.condition,
    required this.availabilityDates,
    required this.accessories,
    required this.pickupOption,
    required this.hasInsurance,
    required this.notes,
    required this.imageUrls,
  });

  /// Convert a Camera object into a map for Firestore or local storage.
  Map<String, dynamic> toMap() {
    return {
      'cameraName': cameraName,
      'equipmentType': equipmentType,
      'brandModel': brandModel,
      'rentalPrice': rentalPrice,
      'securityDeposit': securityDeposit,
      'condition': condition,
      'availabilityDates': availabilityDates.map((date) => date.toIso8601String()).toList(),
      'accessories': accessories,
      'pickupOption': pickupOption,
      'hasInsurance': hasInsurance,
      'notes': notes,
      'imageUrls': imageUrls,
    };
  }

  /// Create a Camera object from a map (useful for retrieving data from Firestore or local storage).
  factory Camera.fromMap(Map<String, dynamic> map) {
    return Camera(
      cameraName: map['cameraName'] ?? '',
      equipmentType: map['equipmentType'] ?? '',
      brandModel: map['brandModel'] ?? '',
      rentalPrice: map['rentalPrice']?.toDouble() ?? 0.0,
      securityDeposit: map['securityDeposit']?.toDouble() ?? 0.0,
      condition: map['condition'] ?? '',
      availabilityDates: List<DateTime>.from(
          (map['availabilityDates'] as List).map((date) => DateTime.parse(date))),
      accessories: List<String>.from(map['accessories'] ?? []),
      pickupOption: map['pickupOption'] ?? '',
      hasInsurance: map['hasInsurance'] ?? false,
      notes: map['notes'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
    );
  }
}
