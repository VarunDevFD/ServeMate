class ImageConcatinate {
  static List<String> concatinateImage(List<String> images) {
    List<String> imageList = [];
    for (int i = 0; i < images.length; i++) {
      if ( i != 0) {
        String a = images[0] + images[i];
        imageList.add(a);
      }  
    }
    return imageList;
  }
}
