import 'package:cloudinary_public/cloudinary_public.dart';

class CloudinaryDataSource {
  final CloudinaryPublic cloudinary;

  CloudinaryDataSource()
      : cloudinary = CloudinaryPublic('dwnoatc3h', 'my_app_preset');

  Future<String> uploadSingleImage(String filePath) async {
    final response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(filePath, resourceType: CloudinaryResourceType.Image),
    );
    return response.secureUrl;
  }

  Future<List<String>> uploadMultipleImages(List<String> filePaths) async {
    final responses = await Future.wait(
      filePaths.map(
        (path) => cloudinary.uploadFile(
          CloudinaryFile.fromFile(path, resourceType: CloudinaryResourceType.Image),
        ),
      ),
    );
    return responses.map((response) => response.secureUrl).toList();
  }
}