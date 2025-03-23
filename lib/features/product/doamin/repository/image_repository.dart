abstract class ImageRepository {
  Future<String> uploadSingleImage(String filePath);
  Future<List<String>> uploadMultipleImages(List<String> filePaths);
}