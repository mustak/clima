import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Position position;
  void getLocation() async {
    LocationPermission permission = await requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await openAppSettings();
    }
    Position pos = await getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      position = pos;
    });
    print(position);
  } //getLocation

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    double lat = position.latitude;
    double long = position.longitude;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('LOCATION:'),
            Text('Lat: $lat'),
            Text('Lon: $long'),
          ],
        ),
      ),
    );
  }
}
