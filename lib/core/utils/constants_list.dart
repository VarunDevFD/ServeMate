import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/images/app_images.dart';
import 'package:serve_mate/features/category/domain/entities/category_entities.dart';

final List<String> appBarTitles = [
  "SERVEMATE",
  "Category List",
  "Add List",
  "Notifications",
  "Profile"
];

const List<String> facilitiesVenue = [
  "Parking",
  "Catering",
  "Stage",
  "Decoration",
  "Air Conditioning",
  "Conference",
  "Free WiFi",
  "Sound System",
  "Projector",
  "Lighting",
  "24/7 Security",
  "Changing Rooms",
  "Restrooms",
  "Outdoor Space",
  "Smoking Area",
  "VIP Lounge",
  "First Aid",
  "Bar Counter",
  "Dance Floor",
  "Pool Access",
  "Gym Access",
  "Play Area for Kids",
  "Valet Parking",
  "Backup Power",
  "AV Equipment",
  "Custom Package",
  "Table and Chair Setup",
  "CCTV Surveillance",
  "Green Rooms",
  "Special Effects",
  "Private Entry",
  "On-site Technician",
  "Cleaning Services",
  "Heating System",
  "Kitchen Access",
  "Pet-Friendly Facility",
  "Wheelchair Access",
  "Eco-Friendly Setup",
  "Dedicated Staff",
  "Live Streaming Support",
  "Flexible Seating Arrangements",
  "On-site Accommodation",
  "Event Insurance",
  "Fireworks Display Zone",
  "Custom Decorations",
  "Cloak Room",
  "Shuttle Service",
  "Photography/Video Services",
  "Live Entertainment Support",
  "Rehearsal Space",
  "Beverage Services",
  "Food Counters",
  "Self-Service Counters",
  "Non-AC Rooms",
  "AC Rooms"
];
const List<String> facilitiesVehicle = [
  // General Vehicle Facilities (Applicable to all types)
  "Air Conditioning",
  "Bluetooth Connectivity",
  "GPS Navigation",
  "Music System",
  "Automatic Transmission",
  "Power Windows",
  "Cruise Control",
  "Backup Camera",
  "Parking Sensors/Camera",
  "Heated Seats",
  "Keyless Entry",
  "Tire Pressure Monitoring System (TPMS)",
  "Wireless Charging Pad",
  "Remote Start",
  "Security System",
  "Lane Assist",

  // Car Specific Facilities
  "Leather Seats",
  "Sunroof",
  "Alloy Wheels",
  "Tow Hook",
  "Bluetooth Audio Streaming",
  "Driver Assistance Systems",
  "Tinted Windows",

  // Bus Specific Facilities
  "Wheelchair Accessibility",
  "Onboard Wi-Fi",
  "Passenger Seats",
  "Air Suspension",
  "Restroom Facility",
  "Bus Wi-Fi",
  "Driver Console",
  "Overhead Luggage Storage",
  "Public Address System (PA)",

  // EV Specific Facilities
  "Electric Charging Port",
  "Regenerative Braking",
  "Battery Health Monitoring",
  "Electric Motor",
  "Eco Mode",
  "Low Emissions",
  "Green Certification",
  "Fast Charging",
  "Solar Roof",
  "EV Range Indicator",

  // Hybrid Vehicle Specific Facilities
  "Hybrid Engine",
  "Electric-Only Mode",
  "Fuel Efficiency Mode",
  "Battery Level Indicator",
  "Automatic Switching Between Power Sources",
  "Hybrid Drive",
  "Low Emissions Mode",
  "Plug-In Hybrid Capability",
  "Energy Regeneration",
];
const List<String> decorThemes = [
  "Traditional",
  "Modern",
  "Rustic",
  "Bohemian",
  "Vintage",
  "Glamorous",
  "Minimalistic",
  "Classic",
  "Cultural",
  "Themed"
];
const List<String> decorationCategory = [
  "Stage & Mandap",
  "Entry Gate",
  "Aisle",
  "Ceiling",
  "Table",
  "Stage",
  "Floral",
  "Lounge",
  "All in All",
];

const List<String> sizeOfFootwear = [
  "below 6",
  "6",
  "7",
  "7.5",
  "8",
  "9",
  "9.5",
  "10",
  "11",
  "Above 11"
];

class VList {
  static const categoryList = [
    Category(name: Names.camera, imageUrl: VImages.cameraImg, userId: null),
    Category(
        name: Names.decoration, imageUrl: VImages.decorationImg, userId: null),
    Category(name: Names.dress, imageUrl: VImages.dressImg, userId: null),
    Category(name: Names.footwear, imageUrl: VImages.footwearImg, userId: null),
    Category(name: Names.jewelry, imageUrl: VImages.jewelryImg, userId: null),
    Category(name: Names.sound, imageUrl: VImages.soundImg, userId: null),
    Category(name: Names.vehicle, imageUrl: VImages.vehiclesImg, userId: null),
    Category(name: Names.venue, imageUrl: VImages.venuesImg, userId: null),
  ];
}
