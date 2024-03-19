import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:weather/models/current_weather_model.dart';
import 'package:weather/models/daily_weather_model.dart';
import 'package:weather/models/hourly_weather_model.dart';
import 'package:weather/utils/urls.dart';

class HomeController extends GetxController {
  // @override
  // void onInit() async {
  //   super.onInit();
  //   getCurrentWeather();
  // }
  bool loading = false;
  bool hourlyDataLoading = false;

  CurrentWeatherModel weatherData = CurrentWeatherModel();
  HourlyWeatherModel hourlyWeatherData = HourlyWeatherModel();
  List<DailyWeatherModel> dailyWeatherData = [];

  Future<void> getCurrentWeather() async {
    loading = true;
    update();
    final response = await get(Uri.parse(Urls.currentWeather));
    if (response.statusCode == 200) {
      print(response.body);
      weatherData = CurrentWeatherModel.fromJson(jsonDecode(response.body));
      loading = false;
      update();
    } else {
      print(response.statusCode);
      log("something went wrong");
      loading = false;
      update();
    }
  }

  Future<void> getHourlyWeather() async {
    hourlyDataLoading = true;
    update();
    final response = await get(Uri.parse(Urls.forecastWeather));
    if (response.statusCode == 200) {
      print(response.body);
      hourlyWeatherData = HourlyWeatherModel.fromJson(jsonDecode(response.body));
      final List<dynamic> data = jsonDecode(response.body)['list'];
      for (int i = 0; i < 5; i++) {
        // Get data for the next 5 days
        final Map<String, dynamic> dayData = data[i * 8]; // Data for each day is at every 8th index
        dailyWeatherData.add(DailyWeatherModel.fromJson(dayData));
      }
      log(dailyWeatherData.toString());
      hourlyDataLoading = false;
      update();
    } else {
      print(response.statusCode);
      log("something went wrong");
      hourlyDataLoading = false;
      update();
    }
  }
}
