import 'package:serve_mate/features/product/data/datasource/cloudinary_datasource.dart';
import 'package:serve_mate/features/product/doamin/repository/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final CloudinaryDataSource dataSource;

  ImageRepositoryImpl(this.dataSource);

  @override
  Future<String> uploadSingleImage(String filePath) async {
    return await dataSource.uploadSingleImage(filePath);
  }

  @override
  Future<List<String>> uploadMultipleImages(List<String> filePaths) async {
    return await dataSource.uploadMultipleImages(filePaths);
  }
}
