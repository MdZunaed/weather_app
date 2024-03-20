import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/constant/app_theme.dart';
import 'package:weather/controller/home_controller.dart';
import 'package:weather/screen/home_screen.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialBinding: ControllerBindings(),
      home: const HomeScreen(),
    );
  }
}

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
