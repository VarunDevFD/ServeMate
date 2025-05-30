// import 'dart:developer'; 
class ImageConcatinate {
  static List<String> concatinateImage(List<String> images) {
    List<String> imageList = [];

    if (images.isEmpty) return imageList;

    String baseUrl = images[0];

    for (int i = 1; i < images.length; i++) {
      // Clean the path: remove leading/trailing quotes and whitespace
      String cleanPath =
          images[i].replaceAll('"', '').replaceAll("'", '').trim();

      // Concatenate with base URL
      String fullUrl = baseUrl + cleanPath;

      imageList.add(fullUrl);
    }

    // log('Concatenated Image List: $imageList');
    return imageList;
     
  }

 
}
