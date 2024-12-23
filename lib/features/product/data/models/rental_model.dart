abstract class RentalItem {
  final String? name; // Define the 'name' field here
  final double? price;
  final double? securityDeposit;
  final String? location;
  final List<String>? images;
  final String? description;

  RentalItem({
    this.name, // Include it in the constructor
    this.price,
    this.securityDeposit,
    this.location,
    this.images,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'securityDeposit': securityDeposit,
      'location': location,
      'images': images,
      'description': description,
    };
  }
}
