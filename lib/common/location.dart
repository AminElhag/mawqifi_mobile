import 'package:geolocator/geolocator.dart';

class Location {
  static Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
  }
}
