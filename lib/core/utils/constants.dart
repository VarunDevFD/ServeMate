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
  // Commonly used strings
  static const initialValue = '';
  static const camera = 'camera';
  static const decoration = 'Decoration';
  static const dress = 'dress';
  static const footwear = 'footwear';
  static const jewelry = 'jewelry';
  static const sound = 'sound';
  static const vehicle = 'Vehicles';
  static const venue = 'venues';
  static const name = 'Name';
  static const location = 'location';
  static const empty = 'Not Found';
  static const color = 'Color';
  static const preData = 'Previous Data';
  static const locationEmpty = 'No Location';
  static const category = 'Category';

  // properties for other fields
  static const price = 'Price';
  static const securityDeposit = 'SecurityDeposit';
  static const description = 'Description';
  static const capacity = 'Capacity';
  static const duration = 'Duration';
  static const venueType = 'VenueType';
  static const phoneNumber = 'PhoneNumber';
  static const seatCapacity = 'SeatCapacity';
  static const images = 'Images';
  static const gender = 'Gender';
  static const date = 'Date';
  static const time = 'Time';
  static const type = 'Type';
  static const size = 'Size';
  static const material = 'Material';
  static const brand = 'Brand';

  // Vehicle & Sound
  static const vehicleN = 'Vehicle';
  static const soundN = 'Sound';
  static const model = 'Model';
  static const vehicleType = 'VehicleType';
  static const vehicleRegNumber = 'Registration Number';
  static const vehiclefuelType = 'Fuel Type';
  static const vehicleTransmission = 'Transmission';
  static const vehicleLocation = '$vehicleN $location';
  static const soundLocation = '$soundN System $location';
  static const soundEquipmentTypes = 'Equipment Types';
  static const soundEquipmentId = 'sound equipment';

  // Jewelry
  static const quantity = 'Quantity';
  static const condition = 'Condition';

  // FootWear
  static const footWearN = 'Footwear';
  static const footWearCategory = '$footWearN $category';

  // Dress
  static const dressN = 'Dress';
  static const dressType = '$dressN type';

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
