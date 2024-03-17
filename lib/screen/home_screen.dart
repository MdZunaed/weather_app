import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/constant/strings.dart';
import 'package:weather/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<HomeController>().getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appbar(),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          // return FutureBuilder(
          //   future: controller.getCurrentWeather(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          var weather = controller.weatherData;
          if (controller.loading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          return RefreshIndicator(
            onRefresh: () => controller.getCurrentWeather(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Text("Bhuigor, Narayanganj", style: theme.textTheme.titleLarge),
                        Text(weather.name?.toUpperCase() ?? "", style: theme.textTheme.titleLarge),
                        Text(DateFormat("yMMMMd").format(DateTime.now()).toString(),
                            style: theme.textTheme.titleMedium),
                      ],
                    ),
                  ),
                  //const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), color: theme.primaryColor.withOpacity(0.1)),
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
                              style: TextStyle(
                                  color: theme.primaryColor, fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              //"Sunny",
                              weather.weather?[0].main ?? '',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        lowHighTemp(theme, weather.main?.tempMin?.toInt(), weather.main?.tempMax?.toInt())
                      ],
                    ),
                  ),
                  //const SizedBox(height: 10),
                  Row(
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
                              borderRadius: BorderRadius.circular(10),
                              color: theme.primaryColor.withOpacity(0.15)),
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
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 150,
                    child: ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 6,
                      separatorBuilder: (c, i) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: theme.primaryColor.withOpacity(0.1)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("${index + 1} AM", style: theme.textTheme.bodyMedium),
                              Image.asset("assets/weather/10n.png", height: 65),
                              Text("35$degree",
                                  style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Next 7 days",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 7,
                    separatorBuilder: (c, i) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      String days = DateFormat("EEEE").format(DateTime.now().add(Duration(days: index + 1)));
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: theme.primaryColor.withOpacity(0.1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(days, style: theme.textTheme.bodyLarge),
                            ),
                            Expanded(
                              child: TextButton.icon(
                                  onPressed: null,
                                  icon: Image.asset("assets/weather/10n.png", width: 40),
                                  label: Text("20$degree",
                                      style: TextStyle(
                                          color: theme.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600))),
                            ),
                            lowHighTemp(theme, 20, 40),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
          //     } else {
          //       return const Center(child: CupertinoActivityIndicator());
          //     }
          //   },
          // );
        },
      ),
    );
  }

  Row lowHighTemp(ThemeData theme, low, high) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.arrow_downward, size: 16),
        Text("$low$degree/", style: theme.textTheme.bodySmall),
        Text("$high$degree", style: theme.textTheme.bodySmall),
        const Icon(Icons.arrow_upward, size: 16),
      ],
    );
  }

  AppBar appbar() {
    ThemeData theme = Theme.of(context);
    Brightness themeMode = theme.brightness;
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
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
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.changeThemeMode(ThemeMode.light);
                },
                child: CircleAvatar(
                  backgroundColor:
                      themeMode == Brightness.light ? Colors.lightBlue.withOpacity(0.6) : Colors.transparent,
                  child: Icon(
                    Icons.light_mode_outlined,
                    color: theme.iconTheme.color,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.changeThemeMode(ThemeMode.dark);
                },
                child: CircleAvatar(
                  backgroundColor: themeMode == Brightness.dark ? Colors.lightBlue : Colors.transparent,
                  child: Icon(Icons.dark_mode_outlined, color: theme.iconTheme.color),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
