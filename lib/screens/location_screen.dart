import 'dart:ui';
import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/popup.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen(this.locationWeather);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;

  String weatherMassage;
  String cityName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      upDateUI(widget.locationWeather);
    });
  }

  void upUI(dynamic data) {
    setState(() {
      if (data == 'no' || data == null) {
        temperature = 0;
        weatherMassage = 'unable to get any weather data!';
        weatherIcon = 'error';
        cityName = 'null';

        showDialog(
          context: context,
          builder: (BuildContext context) =>
              Pup().buildCityPopupDialog(context),
        );
        return;
      }
      var temp = data['main']['temp'];
      temperature = temp.toInt();
      weatherMassage = weather.getMessage(temperature);
      var condition = data['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = data['name'];
    });
  }

  void upDateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherMassage = 'unable to get any weather data!';
        weatherIcon = 'error';
        cityName = 'null';
        Pup pup = Pup();
        showDialog(
          context: context,
          builder: (BuildContext context) => pup.buildPopupDialog(context),
        );
        return;
      }
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weatherMassage = weather.getMessage(temperature);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        upDateUI(weatherData);

                        print('flat button');
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var myData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CityScreen()));
                        if (myData != null) {
                          var data = await weather.getCityWeather(myData);
                          upUI(data);
                          print('flat button city');
                          print(myData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$weatherMassage in $cityName!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
