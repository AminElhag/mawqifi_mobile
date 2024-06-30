import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Location {
  static Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
  }

  static Future<void> askForLocationPermission() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.location,
    ].request();
  }
}
