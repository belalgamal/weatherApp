import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '1454a55fcea88c2b1b96cd184b766867';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    if (cityName != null) {
      await Location().getCurrentLocation();
      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
      var data = await networkHelper.getData();
      return data;
    } else
      return 'no';
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦ice time';
    } else if (temp > 20) {
      return 'Time for shorts and a shirt👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣a scarf and a gloves🧤';
    } else {
      return 'Bring a jacket🧥 just in case';
    }
  }
}
