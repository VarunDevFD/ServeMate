import 'package:flutter_screenutil/flutter_screenutil.dart';

class Size {
  double availableSize(int count, {double minH = 290}) {
    double maxHeight;
    switch (count) {
      case 1:
        maxHeight = minH.h;
        break;
      case 2:
        maxHeight = minH * 2.h;
        break;
      case 3:
        maxHeight = minH * 3.h;
        break;
      case 4:
        maxHeight = minH * 4.h;
        break;
      case 5:
        maxHeight = minH * 5.h;
        break;
      case 6:
        maxHeight = minH * 6.h;
        break;
      case 7:
        maxHeight = minH * 7.h;
        break;
      case 8:
        maxHeight = minH * 8.h;
        break;

      default:
        maxHeight = minH.h;
        break;
    }
    return maxHeight;
  }
}
