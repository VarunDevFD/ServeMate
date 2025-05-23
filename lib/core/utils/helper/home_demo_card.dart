import 'package:serve_mate/core/utils/constants.dart';

class CatUtils {
  static String image(String name) {
    switch (name) {
      case Names.camera:
        return "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/cameras.jpg";
      case Names.decoration:
        return "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/decoration.jpg";
      case Names.dress:
        return "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/dresses.jpg";
      case Names.footwear:
        return "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/footwear.jpg";
      case Names.jewelry:
        return "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/jewelry.jpg";
      case Names.sound:
        return "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/sound&dj.jpg";
      case Names.vehicle:
        return "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/vehicles.jpg";
      case Names.venue:
        return "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/venues.jpg";
      default:
        return "https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/cameras.jpg";
    }
  }

  static String description(String name) {
    switch (name) {
      case Names.camera:
        return 'Rent premium cameras\nfor events, shoots & more!';
      case Names.decoration:
        return 'Stylish decorations\nfor weddings, parties & more!';
      case Names.dress:
        return 'Trendy dresses available\nfor rent at affordable prices.';
      case Names.footwear:
        return 'Elegant footwear to\ncomplete your perfect look.';
      case Names.jewelry:
        return 'Glamorous jewelry pieces\nfor every special moment.';
      case Names.sound:
        return 'Powerful sound & DJ\nsetup for unforgettable vibes.';
      case Names.vehicle:
        return 'Luxury vehicles available\nfor transport and events.';
      case Names.venue:
        return 'Explore spacious venues\nfor your perfect occasion.';
      default:
        return 'Discover high-quality rentals\nfor every event & need!';
    }
  }
}
