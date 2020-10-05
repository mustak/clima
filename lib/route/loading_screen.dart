import 'package:flutter/material.dart';
import 'package:clima_app/services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = Location();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    await location.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    double lat = location.latitude;
    double long = location.longitude;
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
