import 'package:flutter/material.dart';

import '../constant/strings.dart';

class LowHighTemp extends StatelessWidget {
  final String lowest;
  final String highest;
  const LowHighTemp({super.key, required this.lowest, required this.highest});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.arrow_downward, size: 16),
        Text("$lowest$degree/", style: theme.textTheme.bodySmall),
        Text("$highest$degree", style: theme.textTheme.bodySmall),
        const Icon(Icons.arrow_upward, size: 16),
      ],
    );
  }
}
