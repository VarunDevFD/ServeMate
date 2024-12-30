class DecorationEntity {
  final String name;
  final double rentalPrice;
  final double securityDeposit;
  final String location;
  final List<String> images;
  final String description;
  final List<String> selectedFacilitiesFirst;
  final List<String> selectedFacilitiesSecond;
  final String date;

  DecorationEntity({
    required this.name,
    required this.rentalPrice,
    required this.securityDeposit,
    required this.location,
    required this.images,
    required this.description,
    required this.selectedFacilitiesFirst,
    required this.selectedFacilitiesSecond,
    required this.date,
  });
}
