import 'package:serve_mate/core/usecase/usecase.dart';
import 'package:serve_mate/features/product/doamin/repository/image_repository.dart';

class UploadMultipleImages implements UseCase<List<String>, List<String>> {
  final ImageRepository repository;

  UploadMultipleImages(this.repository);

  @override
  Future<List<String>> call(List<String> filePaths) async {
    return await repository.uploadMultipleImages(filePaths);
  }
}
