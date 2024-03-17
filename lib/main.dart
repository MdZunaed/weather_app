import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/constant/app_theme.dart';
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
      themeMode: ThemeMode.system,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   scaffoldBackgroundColor: Colors.grey,
      //   useMaterial3: true,
      // ),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}