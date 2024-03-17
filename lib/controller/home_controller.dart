import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:weather/models/current_weather_model.dart';
import 'package:weather/utils/urls.dart';

class HomeController extends GetxController {
  // @override
  // void onInit() async {
  //   super.onInit();
  //   getCurrentWeather();
  // }
  bool loading = false;

  CurrentWeatherModel weatherData = CurrentWeatherModel();

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
}
