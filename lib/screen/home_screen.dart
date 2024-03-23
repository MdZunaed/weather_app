import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/constant/strings.dart';
import 'package:weather/controller/home_controller.dart';
import 'package:weather/models/current_weather_model.dart';
import 'package:weather/models/hourly_weather_model.dart';
import 'package:weather/widgets/days_weather_card.dart';
import 'package:weather/widgets/hourly_temp_card.dart';
import 'package:weather/widgets/loading_indicator.dart';

import '../widgets/low_high_temp.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<HomeController>().getUserPermission();
    //if (Get.find<HomeController>().loaded == true) {
    //   Get.find<HomeController>().getCurrentWeather();
    //   Get.find<HomeController>().getHourlyWeather();
    // }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appbar(),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          var weather = controller.weatherData;
          var hWeather = controller.hourlyWeatherData;
          if (controller.loaded == false) {
            return const LoadingIndicator();
          }
          if (controller.loading) {
            return const LoadingIndicator();
          }
          return RefreshIndicator(
            onRefresh: () => controller.onRefreshScreen(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  locationAndDate(weather, theme),
                  currentTemperature(theme, weather),
                  cloudHumidityWindSpeed(weather, theme),
                  const SizedBox(height: 20),
                  hourlyTemperature(controller, hWeather),
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Next 5 days", style: theme.textTheme.titleSmall)),
                  const SizedBox(height: 10),
                  nextFiveDaysWeather(controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Align locationAndDate(CurrentWeatherModel weather, ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(weather.name?.toUpperCase() ?? "", style: theme.textTheme.titleLarge?.copyWith(fontSize: 28)),
          Text(DateFormat("yMMMMd").format(DateTime.now()).toString(), style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }

  Visibility nextFiveDaysWeather(HomeController controller) {
    return Visibility(
      visible: controller.hourlyDataLoading == false,
      replacement: const CupertinoActivityIndicator(),
      child: ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemCount: controller.dailyWeatherData.length,
        separatorBuilder: (c, i) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          var dayWeather = controller.dailyWeatherData[index];
          String days = DateFormat("EEEE").format(DateTime.now().add(Duration(days: index + 1)));
          var temp = dayWeather.temp.toInt();
          var icon = dayWeather.weatherIcon;
          var lowest = dayWeather.minTemp.toInt();
          var highest = dayWeather.maxTemp.toInt();
          return DaysWeatherCard(
              days: days, icon: icon, temp: "$temp", lowest: "$lowest", highest: "$highest");
        },
      ),
    );
  }

  Visibility hourlyTemperature(HomeController controller, HourlyWeatherModel hWeather) {
    return Visibility(
      visible: controller.hourlyDataLoading == false,
      replacement: const CupertinoActivityIndicator(),
      child: SizedBox(
        height: 150,
        child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: (hWeather.list?.length ?? 0) > 8 ? 8 : (hWeather.list?.length ?? 0),
          separatorBuilder: (c, i) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            var time = DateFormat.jm()
                .format(DateTime.fromMillisecondsSinceEpoch(hWeather.list![index].dt!.toInt() * 1000));
            var icon = hWeather.list?[index].weather?[0].icon;
            var temp = hWeather.list?[index].main?.temp?.toInt();
            return HourlyTempCard(time: time, icon: icon, temp: "$temp");
          },
        ),
      ),
    );
  }

  Container currentTemperature(ThemeData theme, CurrentWeatherModel weather) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: theme.primaryColor.withOpacity(0.1)),
      child: Column(
        children: [
          Image.asset(
              //"assets/weather/10n.png",
              "assets/weather/${weather.weather?[0].icon}.png",
              height: 120,
              fit: BoxFit.cover),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                //"32$degree",
                "${weather.main?.temp?.toInt()}$degree",
                style: TextStyle(color: theme.primaryColor, fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5),
              Text(
                //"Sunny",
                weather.weather?[0].main ?? '',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          LowHighTemp(
              lowest: "${weather.main?.tempMin?.toInt()}", highest: "${weather.main?.tempMax?.toInt()}")
        ],
      ),
    );
  }

  Row cloudHumidityWindSpeed(CurrentWeatherModel weather, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        3,
        (index) {
          List images = [clouds, humidity, windSpeed];
          List values = [
            "${weather.clouds?.all}%",
            "${weather.main?.humidity}%",
            "${weather.wind?.speed} km/h"
          ];
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: theme.primaryColor.withOpacity(0.15)),
            child: Column(
              children: [
                Image.asset(images[index], height: 60),
                const SizedBox(height: 5),
                Text(
                  values[index],
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar appbar() {
    ThemeData theme = Theme.of(context);
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(5),
        child: GestureDetector(
          onTap: () {
            Get.snackbar("⚠️", "Under Development");
          },
          child: CircleAvatar(
            backgroundColor: theme.primaryColor.withOpacity(0.15),
            child: Icon(Icons.widgets_outlined, color: theme.iconTheme.color),
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.15), borderRadius: BorderRadius.circular(35)),
          child: GetBuilder<HomeController>(builder: (controller) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.changeThemeMode();
                  },
                  child: CircleAvatar(
                    backgroundColor:
                        controller.darkMode ? Colors.transparent : Colors.lightBlue.withOpacity(0.5),
                    child: Icon(
                      Icons.light_mode_outlined,
                      color: theme.iconTheme.color,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.changeThemeMode();
                  },
                  child: CircleAvatar(
                    backgroundColor:
                        controller.darkMode ? Colors.lightBlue.withOpacity(0.5) : Colors.transparent,
                    child: Icon(Icons.dark_mode_outlined, color: theme.iconTheme.color),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
