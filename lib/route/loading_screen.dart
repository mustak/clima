import 'package:flutter/material.dart';
import 'package:clima_app/route/location.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(
          weatherData: weatherData,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              // print(index);
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven ? Colors.amber[700] : Colors.amber[200],
                ),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Loading Weather...',
            style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 2,
              fontFamily: 'Spartan MB',
            ),
          )
        ],
      ),
    );
  }
}
