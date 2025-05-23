import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthConstants {
  static const String userNotFound = 'User not found';
  static const String wrongPassword = 'Wrong password';
  static const String appName = "ServeMate Wedding Rentals";
  // Add more constants as needed
}

class AppPadding {
  static final paddingEdgesAll = EdgeInsets.all(20.r);
}

class Names {
  static const initialValue = '';
  static const camera = 'camera';
  static const decoration = 'Decoration';
  static const dress = 'dress';
  static const footwear = 'footwear';
  static const jewelry = 'jewelry';
  static const sound = 'sound';
  static const vehicle = 'Vehicles';
  static const venue = 'venues';
  static const name = 'name';
  static const location = 'location';
  static const empty = 'Not Found';

  static List<String> categoryNamesList = [
    Names.camera,
    Names.decoration,
    Names.dress,
    Names.footwear,
    Names.jewelry,
    Names.sound,
    Names.vehicle,
    Names.venue
  ];

  static Map<String, bool> categoryNamesMap = {
    Names.camera: false,
    Names.decoration: false,
    Names.dress: false,
    Names.footwear: false,
    Names.jewelry: false,
    Names.sound: false,
    Names.vehicle: false,
    Names.venue: false,
  };

  static Map<String, String> sponsorLogos = {
    "CR7":
        "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/sponsors/Cr7_img.jpg",
    "Brototype":
        "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/sponsors/brototype_img.jpg",
    "Lee Chong Wei":
        "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/sponsors/leeChongWei-img.jpg",
    "Ruud Gulit":
        "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/sponsors/ruudGulit-imge.jpg",
    "Surya":
        "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/sponsors/surya-img.jpg",
    "Virender Sehwag":
        "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/sponsors/virubhai-img.jpg",
  };
}
