import 'package:serve_mate/features/product/doamin/entities/venue_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class VenueUseCase {
  final ProductRepository repository;

  VenueUseCase(this.repository);

  Future<void> execute(VenueEntity venueEntity) async {
    return await repository.addVenue(venueEntity);
  }

  Future<List<VenueEntity>> fetchVenues() async {
    return await repository.fetchVenues();
  }
}
