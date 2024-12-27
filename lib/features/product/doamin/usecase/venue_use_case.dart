import 'package:serve_mate/features/product/doamin/entities/venue_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class AddVenueUseCase {
  final ProductRepository repository;

  AddVenueUseCase(this.repository);

  Future<void> execute(VenueEntity venueEntity) async {
    return await repository.addVenue(venueEntity);
  }
}
