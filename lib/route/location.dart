import 'package:flutter/material.dart';
import 'package:clima_app/utilities/constants.dart';
import 'package:clima_app/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final dynamic weatherData;

  LocationScreen({this.weatherData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel _weatherModel = WeatherModel();
  int _temp;
  String _city;
  String _weatherIcon;
  String _weatherMessage;

  @override
  void initState() {
    super.initState();

    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    double temp = weatherData['main']['temp'];
    setState(() {
      _temp = temp.floor();
      int _condition = weatherData['weather'][0]['id'];
      _city = weatherData['name'];
      _weatherIcon = _weatherModel.getWeatherIcon(_condition);
      _weatherMessage = _weatherModel.getMessage(_temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/location_bg.jpg'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.3), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$_temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      _weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$_weatherMessage in $_city',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
