import 'dart:developer';

import 'package:serve_mate/features/product/doamin/entities/venue.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class VenueUseCase {
  final ProductRepository repository;

  VenueUseCase(this.repository);

  Future<void> execute(Venue venue) async {
    log("Venue Repository keri usecase");
    return await repository.addVenue(venue);
  }

  Future<List<Venue>> fetchVenues() async {
    return await repository.fetchVenues();
  }
}
