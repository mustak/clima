import 'package:geolocator/geolocator.dart';

class Location {
  double longitude;
  double latitude;

  Future<void> getCurrentLocation() async {
    if (await _accessDenied()) {
      await openAppSettings();
    }
    try {
      Position pos = await getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      longitude = pos.longitude;
      latitude = pos.latitude;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _accessDenied() async {
    LocationPermission permission = await requestPermission();
    return (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever)
        ? true
        : false;
  }
}
