import 'package:weather/utils/api_key.dart';

class Urls {
  static const baseUrl = "https://api.openweathermap.org/data/2.5";
  static currentWeather(lat, lon) => "$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey";
  static const forecastWeather = "$baseUrl/forecast?lat={lat}&lon={lon}&appid={API key}";
}
