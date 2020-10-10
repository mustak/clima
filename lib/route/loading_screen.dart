import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clima_app/services/location.dart';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  String city;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    setState(() {
      latitude = location.latitude;
      longitude = location.longitude;
    });
  }

  void getData() async {
    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02');

    if (response.statusCode == 200) {
      String data = response.body;

      var weatherData = jsonDecode(data);

      city = weatherData['name'];
      double temp = weatherData['main']['temp'];
      int condition = weatherData['weather'][0]['id'];
      print(condition);
    } else {
      print(response.statusCode);
      // throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('LOCATION:'),
            Text('Lat: $latitude'),
            Text('Lon: $longitude'),
            Text('City: $city'),
          ],
        ),
      ),
    );
  }
}
