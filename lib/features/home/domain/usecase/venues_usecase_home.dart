import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/models/venues_model.dart';
import 'package:serve_mate/features/home/domain/repository/domain_home_category_repository.dart';

class VenuesUsecaseHome {
  final repository = serviceLocator<HomeCategoryRepository>();

  Future<List<VenueModel>> call() async {
    return await repository.getVenues();
  }
}
