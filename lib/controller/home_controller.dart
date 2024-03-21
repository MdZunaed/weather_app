import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  //   await Get.find<HomeController>().getUserPermission();
  //   Get.find<HomeController>().getCurrentWeather();
  //   Get.find<HomeController>().getHourlyWeather();
  // }

  bool loading = false;
  bool loaded = false;
  bool hourlyDataLoading = false;
  bool darkMode = false;

  double latitude = 23.6850;
  double longitude = 90.3563;
  CurrentWeatherModel weatherData = CurrentWeatherModel();
  HourlyWeatherModel hourlyWeatherData = HourlyWeatherModel();
  List<DailyWeatherModel> dailyWeatherData = [];

  void changeThemeMode() {
    darkMode = !darkMode;
    Get.changeThemeMode(darkMode ? ThemeMode.dark : ThemeMode.light);
    update();
  }

  getUserPermission() async {
    bool isLocationEnabled;
    LocationPermission locationPermission;
    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    locationPermission = await Geolocator.checkPermission();
    if (!isLocationEnabled) {
      return Future.error("Location is not enabled");
    }
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Permission is denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Permission is denied");
      }
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((locationData) {
      latitude = locationData.latitude;
      longitude = locationData.longitude;

      log(latitude.toString());
      log(longitude.toString());
    }).then((value) {
      getCurrentWeather();
      getHourlyWeather();
      loaded = true;
      update();
    });
  }

  Future<void> getCurrentWeather() async {
    loading = true;
    update();
    final response = await get(Uri.parse(Urls.currentWeather(latitude, longitude)));
    if (response.statusCode == 200) {
      log(response.body);
      weatherData = CurrentWeatherModel.fromJson(jsonDecode(response.body));
      loading = false;
      update();
    } else {
      log(response.statusCode.toString());
      log("something went wrong");
      loading = false;
      update();
    }
  }

  Future<void> getHourlyWeather() async {
    hourlyDataLoading = true;
    update();
    final response = await get(Uri.parse(Urls.forecastWeather(latitude, longitude)));
    if (response.statusCode == 200) {
      log(response.body);
      hourlyWeatherData = HourlyWeatherModel.fromJson(jsonDecode(response.body));
      final List<dynamic> data = jsonDecode(response.body)['list'];
      for (int i = 0; i < 5; i++) {
        // Get data for the next 5 days
        final Map<String, dynamic> dayData = data[i * 8]; // Data for each day is at every 8th index
        dailyWeatherData.add(DailyWeatherModel.fromJson(dayData));
      }
      log(dailyWeatherData.toString());
      hourlyDataLoading = false;
      //loaded = true;
      update();
    } else {
      log(response.statusCode.toString());
      log("something went wrong");
      hourlyDataLoading = false;
      update();
    }
  }
}
