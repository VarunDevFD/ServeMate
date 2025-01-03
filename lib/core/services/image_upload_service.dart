import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageUploadService {
  final String cloudinaryUrl =
      "https://api.cloudinary.com/v1_1/dwnoatc3h/image/upload";
  final String uploadPreset = "servemate_img";

  // Upload image function
  Future<String> uploadImage(String imagePath) async {
    try {
      // Validate the file path
      var imageFile = File(imagePath);
      if (!imageFile.existsSync()) {
        throw Exception("Image not found at the provided path: $imagePath");
      }

      // Prepare request
      var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imagePath));

      // Send the request
      var response = await request.send();

      // Handle response
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseData);

        // Return the URL of the uploaded image
        return jsonResponse['secure_url'];
      } else {
        var errorResponse = await response.stream.bytesToString();
        throw Exception(
            "Failed to upload image: ${response.statusCode}, Details: $errorResponse");
      }
    } catch (e) {
      throw Exception("Error uploading image: $e");
    }
  }
}
