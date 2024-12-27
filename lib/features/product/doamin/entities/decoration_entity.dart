class DecorationEntity {
  final String name;
  final double rentalPrice;
  final double securityDeposit;
  final String location;
  final List<String> imageUrls;
  final String description;
  final List<String> selectedFacilitiesFirst;
  final List<String> selectedFacilitiesSecond;
  final String date;

  DecorationEntity({
    required this.name,
    required this.rentalPrice,
    required this.securityDeposit,
    required this.location,
    required this.imageUrls,
    required this.description,
    required this.selectedFacilitiesFirst,
    required this.selectedFacilitiesSecond,
    required this.date,
  });
}
