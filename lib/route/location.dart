import 'package:flutter/material.dart';
import 'package:clima_app/utilities/constants.dart';
import 'package:clima_app/services/weather.dart';
import 'package:clima_app/route/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final dynamic weatherData;

  LocationScreen({this.weatherData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel _weatherModel = WeatherModel();
  String _temp;
  // String _city;
  String _weatherIcon;
  String _weatherMessage;
  bool _updating = true;

  @override
  void initState() {
    super.initState();

    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    // weatherData = null;
    setState(() {
      if (weatherData == null) {
        _temp = ' ';
        _weatherIcon = ' ';
        _weatherMessage = 'Error occured.';
        _updating = false;
        return;
      }
      double temp = weatherData['main']['temp'];
      int t = temp.floor();
      _temp = '${t.toString()}°';
      int _condition = weatherData['weather'][0]['id'];
      String _city = weatherData['name'];
      _weatherIcon = _weatherModel.getWeatherIcon(_condition);
      _weatherMessage = '${_weatherModel.getMessage(t)} in $_city';
      _updating = false;
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
                    onPressed: () async {
                      setState(() {
                        _updating = true;
                      });
                      var weatherData =
                          await WeatherModel().getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.gps_fixed, //Icons.near_me,
                      size: 40.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      String cityName = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }),
                      );

                      if (cityName != null) {
                        setState(() {
                          _updating = true;
                        });
                        var weatherData = await WeatherModel()
                            .getLocationWeather(cityName: cityName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.input,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              (_updating)
                  ? CircularProgressIndicator(
                      value: null,
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '$_temp',
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
                  '$_weatherMessage',
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
