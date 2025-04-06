import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart'; // For encryption
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageHandler {
  final CloudinaryPublic cloudinary = CloudinaryPublic(
    dotenv.env['CLOUDINARY_CLOUD_NAME']!,
    dotenv.env['CLOUDINARY_UPLOAD_PRESET']!,
  ); // Configure with your Cloudinary credentials

  // Generate a unique filename based on the original path
  String _generateUniqueFilename(String path) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = md5.convert(utf8.encode(path + timestamp)).toString();
    return hash;
  }

  // Process and upload multiple images
  Future<List<String>> processAndUploadImages(List<String> imagePaths) async {
    String cloudInitiUrl =
        'https://res.cloudinary.com/${dotenv.env['CLOUDINARY_CLOUD_NAME']}/image/upload/';
    List<String> urls = [cloudInitiUrl];

    for (String path in imagePaths) {
      // Upload to Cloudinary
      String cloudinaryUrl = await _uploadToCloudinary(path);

      // InitalUrl remove
      String imagePath = cloudinaryUrl.replaceAll(cloudInitiUrl, '');

      // Split the URL to store the path
      urls.add(imagePath);
    }

    return urls;
  }

  // Upload to Cloudinary and return the URL
  Future<String> _uploadToCloudinary(String imagePath) async {
    File imageFile = File(imagePath);
    final filename = _generateUniqueFilename(imagePath);

    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imageFile.path,
          resourceType: CloudinaryResourceType.Image,
          publicId: filename,
        ),
      );

      return response.secureUrl;
    } catch (e) {
      throw Exception('Failed to upload to Cloudinary: $e');
    }
  }
}
