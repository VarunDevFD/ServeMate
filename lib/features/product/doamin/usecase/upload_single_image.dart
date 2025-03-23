import 'package:serve_mate/core/usecase/usecase.dart';
import 'package:serve_mate/features/product/doamin/repository/image_repository.dart';

class UploadSingleImage implements UseCase<String, String> {
  final ImageRepository repository;

  UploadSingleImage(this.repository);

  @override
  Future<String> call(String filePath) async {
    return await repository.uploadSingleImage(filePath);
  }
}