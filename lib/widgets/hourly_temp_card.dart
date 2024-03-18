import 'package:flutter/material.dart';

import '../constant/strings.dart';

class HourlyTempCard extends StatelessWidget {
  final String time;
  final String? icon;
  final String temp;
  const HourlyTempCard({super.key, required this.time, required this.icon, required this.temp});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: theme.primaryColor.withOpacity(0.1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(time, style: theme.textTheme.bodyMedium),
          Image.asset("assets/weather/$icon.png", height: 65),
          Text(
            "$temp$degree",
            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
