import 'package:flutter/material.dart';
import 'package:weather/widgets/low_high_temp.dart';

import '../constant/strings.dart';

class DaysWeatherCard extends StatelessWidget {
  final String days;
  final String icon;
  final String temp;
  final String lowest;
  final String highest;
  const DaysWeatherCard(
      {super.key,
      required this.days,
      required this.icon,
      required this.temp,
      required this.lowest,
      required this.highest});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: theme.primaryColor.withOpacity(0.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(days, style: theme.textTheme.bodyLarge),
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: null,
              icon: Image.asset("assets/weather/$icon.png", width: 40),
              label: Text(
                "$temp$degree",
                style: TextStyle(color: theme.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          LowHighTemp(lowest: lowest, highest: highest),
        ],
      ),
    );
  }
}
