import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageHelper {
  static Widget updateCachedNetworkImage({
    required String imageUrl,
    double width = 150,
    double height = 180,
    BoxFit fit = BoxFit.cover,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width.w,
      height: height.h,
      fit: fit,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  static List<String> fileToString(List<File> files) {
    if (files.isEmpty) {
      return [];
    }
    return files.map((file) => file.path).toList();

  }
}
