import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/venues_model.dart';
import 'package:serve_mate/features/category_list/domain/repository/repo_category.dart';

class GetVenuesUseCase {
  final repository = serviceLocator<H2CategoryRepository>();

  Future<List<VenueModel>> call() async {
    return await repository.getVenues();
  }

  Future<void> update(String dId, VenueModel model) async {
    return await repository.updateVenue(dId, model);
  }
}
