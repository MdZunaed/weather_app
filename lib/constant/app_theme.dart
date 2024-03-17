import 'package:flutter/material.dart';
import 'package:weather/constant/colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: whiteColor,
    appBarTheme: const AppBarTheme(backgroundColor: whiteColor),
    iconTheme: const IconThemeData(color: Colors.deepPurple),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: Colors.deepPurple, fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(color: Colors.deepPurple, fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: bgColor,
    appBarTheme: const AppBarTheme(backgroundColor: bgColor),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}
